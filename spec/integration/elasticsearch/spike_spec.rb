require 'spec_helper'
require 'logger'

describe Elasticsearch do
  let(:uri) { 'http://localhost:9200' }

  SINGLE_NODE_SETTINGS = IceNine.deep_freeze(
    :settings => {
      :number_of_shards => 1,
      :number_of_replicas => 0
    }
  )

  let(:cluster) { Elasticsearch::Cluster.connect(uri, Logger.new($stderr, :debug)) }

  it 'should work' do
    cluster.present_indices.each do |index|
      index.delete
    end

    index_a = cluster.index('test-a')
    index_a.create(SINGLE_NODE_SETTINGS)

    index_b = cluster.index('test-b')
    index_b.create(SINGLE_NODE_SETTINGS)

    indices = cluster.indices(%w(test-a test-b))

    result_a = index_a.type('type-a').index({'foo' => 'bar'})
    result_b = index_b.type('type-b').index({'foo' => 'baz'})

    cluster.health(:wait_for_status => :green, :timeout => '10s')

    indices.refresh

    result = index_a.read({:query => { :match_all => {}}})
    result.hits.map(&:source).should eql([{'foo' => 'bar'}])

    result = indices.read({:query => { :match_all => {}}})

    result.hits.map(&:source).to_set.should eql([{'foo' => 'bar'}, {'foo' => 'baz'}].to_set)

    index_a.type('type-a').document(result_a.id).delete

  end
end
