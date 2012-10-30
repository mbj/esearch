require 'spec_helper'

describe Elasticsearch::Connection,'#setup' do
  subject          { object.setup(name) }

  let(:object)     { described_class.new(uri,options) }
  let(:uri)        { 'http://example.com:9200' }
  let(:options)    { { :adapter => [:test,adapter] } }
  let(:name)       { :test }

  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.send(verb,path,req_body) do
        [status,{'content-type' => content_type},res_body]
      end
    end
  end

  let(:verb)         { :put }
  let(:req_body)     { MultiJson.dump(expected_settings) }
  let(:content_type) { 'application/json; charset=UTF-8' }
  let(:res_body)     { '{}' }
  let(:path)         { '/test' }

  let(:expected_settings) do
    described_class::DEFAULT_INDEX_SETTINGS.merge(settings)
  end

  let(:settings) { {} }

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
      expect { subject }.to raise_error(Elasticsearch::RemoteError,'{}')
    end
  end

  context 'when remote timeout occurs' do
    let(:res_body) { MultiJson.dump(:timeout => true) }

    it 'should raise error' do
      pending
      expect { subject }.to raise_error(Elasticsearch::RemoteError,res_body)
    end
  end
end
