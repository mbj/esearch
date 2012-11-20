require 'spec_helper'

describe Elasticsearch::Connection,'#wait' do
  subject          { object.wait(name) }

  let(:object)     { described_class.new(uri,options) }
  let(:uri)        { 'http://example.com:9200' }
  let(:options)    { { :adapter => [:test,adapter] } }
  let(:name)       { :test }
  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.send(verb,path) do
        [status,{'content-type' => content_type},body]
      end
    end
  end

  let(:verb)         { :get }
  let(:content_type) { 'application/json; charset=UTF-8' }
  let(:body)         { '{}' }
  let(:path)         { '/_cluster/health/test?level=index&timeout=60s&wait_for_status=green' }

  context 'when request is successful' do
    let(:status) { 200 }

    it 'should execute requests' do
      subject
      adapter.verify_stubbed_calls
    end

    it_should_behave_like 'a command method'
  end

  context 'when request is NOT successful' do
    let(:status) { 500 }

    it 'should raise error' do
      expect { subject }.to raise_error(Elasticsearch::RemoteError, '{}')
    end
  end

  context 'when remote timeout occurs' do
    let(:body) { MultiJson.dump(:timeout => true) }

    it 'should raise error' do
      pending
      expect { subject }.to raise_error(Elasticsearch::RemoteError, body)
    end
  end
end
