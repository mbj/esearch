require 'spec_helper'

describe Elasticsearch::Connection,'#exist?' do
  let(:object)     { described_class.new(uri,options) }
  let(:name)       { 'test' }
  let(:uri)        { 'http://example.com:9200' }

  let(:options) { { :adapter => [:test,adapter] } }

  subject { object.exist?(name) }

  let(:adapter) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      method,path,result = request
      stub.send(method,path) do
        result
      end
    end
  end

  context 'when index does exist' do
    let(:request) do
      [:head,'/test',[status,{'content-type' => 'application/json; charset=UTF-8'},'{}']]
    end

    context 'and request is successful' do
      let(:status) { 200 }

      it 'should execute requests' do
        subject
        adapter.verify_stubbed_calls
      end

      it { should be(true) }
    end

    context 'and request is NOT successful' do
      let(:status) { 500 }

      it 'should raise error' do
        expect { subject }.to raise_error(Elasticsearch::RemoteError,'{}')
      end
    end
  end

  context 'when index does NOT exist' do
    let(:request) do
      [:head,'/test',[404,{},'']]
    end

    it 'should execute requests' do
      subject
      adapter.verify_stubbed_calls
    end

    it { should be(false) }
  end
end
