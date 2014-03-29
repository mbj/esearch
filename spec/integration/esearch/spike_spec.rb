# encoding: UTF-8

require 'spec_helper'
require 'logger'

describe Esearch do
  before do
    pending
  end
  let(:uri) { ENV.fetch('ESEARCH_TEST_URI', 'http://localhost:9200') }

  SINGLE_NODE_SETTINGS = IceNine.deep_freeze(
    settings: {
      number_of_shards: 1,
      number_of_replicas: 0
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

    result_a = index_a.type('type-a').index('foo' => 'bar')
    result_b = index_b.type('type-b').index('foo' => 'baz')

    cluster.health(wait_for_status: :green, timeout: '10s')

    indices.refresh

    result = index_a.search(query: { match_all: {} })
    result.hits.map(&:source).should eql([{ 'foo' => 'bar' }])

    result = indices.search(query: { match_all: {} })

    result.hits.map(&:source).to_set.should eql([{ 'foo' => 'bar' }, { 'foo' => 'baz' }].to_set)

    index_a.type('type-a').document(result_a.id).delete

    document = index_b.type('type-b').document(result_b.id).get
    document.source.should eql('foo' => 'baz')
  end
end
