require 'spec_helper'
require 'logger'

describe Esearch do
  let(:uri) { ENV.fetch('ESEARCH_TEST_URI', 'http://localhost:9200') }

  SINGLE_NODE_SETTINGS = IceNine.deep_freeze(
    :settings => {
      :number_of_shards => 1,
      :number_of_replicas => 0
    }
  )

  let(:cluster) { Esearch::Cluster.connect(uri, Logger.new($stderr, :debug)) }

  it 'should work' do
    cluster.all_indices.status.indices.map do |index|
      cluster.index(index.name).delete
    end

    index_a = cluster.index('test-a')
    index_a.exist?.should be(false)
    index_a.create(SINGLE_NODE_SETTINGS)
    index_a.exist?.should be(true)

    index_b = cluster.index('test-b')
    index_b.create(SINGLE_NODE_SETTINGS)

    indices = cluster.indices(%w(test-a test-b))

    result_a = index_a.type('type-a').index({'foo' => 'bar'})
    result_b = index_b.type('type-b').index({'foo' => 'baz'})
    result_c = index_a.type('type-a').document('test-3').index_create({'foo' => 'test-3'})

    cluster.health(:wait_for_status => :green, :timeout => '10s')

    indices.refresh

    result = index_a.search({:query => { :match_all => {}}})
    result.hits.map(&:source).should eql([{'foo' => 'bar'}, {'foo' => 'test-3'}])

    result = indices.search({:query => { :match_all => {}}})

    result.hits.map(&:source).to_set.should eql([{'foo' => 'bar'}, {'foo' => 'baz'}, {'foo' => 'test-3'}].to_set)

    expect {
      index_a.type('type-a').document(result_a.id).index_create({'foo' => 'bar'})
    }.to raise_error(Esearch::ProtocolError)

    index_a.type('type-a').document(result_a.id).delete

    document = index_b.type('type-b').document(result_b.id).get
    document.source.should eql('foo' => 'baz')

    index_b.type('type-b').document(result_b.id).index_update({'test4' => 'ok'})
    document = index_b.type('type-b').document(result_b.id).get
    document.source.should eql('test4' => 'ok')

    index_b.type('type-b').document(result_b.id).index({'test5' => 'ok'})
    document = index_b.type('type-b').document(result_b.id).get
    document.source.should eql('test5' => 'ok')

    expected = 1
    count = 4

    3.times do
      index_a.type('type-a').document('test-4').update({
        "script" => "ctx._source.counter += count",
        "params" => { "count" => count },
        "upsert" => { "counter" => 1 }
      })
      document = index_a.type('type-a').document('test-4').get
      document.source.should eql({'counter' => expected})
      expected += count
    end

    cluster.update_aliases({
      "actions" => [{ "add" => { "index" => 'test-a', 'alias' => 'alias-a' } }]
    })

  end
end
