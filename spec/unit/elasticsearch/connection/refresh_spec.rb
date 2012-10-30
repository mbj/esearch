require 'spec_helper'

describe Elasticsearch::Connection,'#refresh' do
  let(:object)     { described_class.new(uri,options) }
  let(:uri)        { 'http://example.com:9200' }
  let(:options)    { { :adapter => [:test,adapter] } }

  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.send(verb,path) do
        [status,{'content-type' => content_type},body]
      end
    end
  end

  let(:verb) { :post }
  let(:content_type) { 'application/json; charset=UTF-8' }
  let(:body) { '{}' }

  context 'when refreshing index' do
    let(:path) { '/test/_refresh' }

    subject { object.refresh('test') }

    context 'and request is successful' do
      let(:status) { 200 }

      it 'should execute requests' do
        subject
        adapter.verify_stubbed_calls
      end

      it_should_behave_like 'a command method'
    end

    context 'and request is NOT successful' do
      let(:status) { 500 }

      it 'should raise error' do
        expect { subject }.to raise_error(Elasticsearch::RemoteError, '{}')
      end
    end
  end

  context 'when refreshing cluster' do
    let(:path) { '/_refresh' }

    subject { object.refresh }

    context 'and request is successful' do
      let(:status) { 200 }

      it 'should execute requests' do
        subject
        adapter.verify_stubbed_calls
      end

      it_should_behave_like 'a command method'
    end

    context 'and request is NOT successful' do
      let(:status) { 500 }

      it 'should raise error' do
        expect { subject }.to raise_error(Elasticsearch::RemoteError, '{}')
      end
    end
  end
end
