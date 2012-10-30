require 'spec_helper'

# This is a pice of mocked shit. But im unable to inject the faraday test adapter nicely.
describe Elasticsearch::Connection, '#read' do
  let(:object)     { described_class.new(uri, options) }
  let(:uri)        { 'http://example.com:9200/index' }
  let(:data)       { { 'a' => 'b' } }
  let(:query)      { { 'foo' => 'bar' } }
  let(:type)       { 'type' }
  let(:logger)     { nil }

  let(:options)    { { :adapter => [:test, adapter] } }

  subject { object.read(type, query) }

  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      method, path, result = request
      stub.send(method, path) do
        result
      end
    end
  end

  context 'with successful read' do
    let(:request) do
      [:get, '/index/type/_search', [200, {'content-type' => 'application/json; charset=UTF-8'}, MultiJson.dump(data)]]
    end

    it { should be_kind_of(Elasticsearch::Result) }

    it 'should execute requests' do
      subject
      adapter.verify_stubbed_calls
    end
  end

  context 'with unsuccessful read' do
    let(:request) do
      [:get, '/index/type/_search', [500, {'content-type' => 'text/html; charset=UTF-8'}, "error"]]
    end

    it 'should raise error' do
      expect { subject }.to raise_error(Elasticsearch::RemoteError, 'error')
    end
  end
end
