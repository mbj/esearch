require 'spec_helper'

describe Esearch::Request do

  let(:object) { described_class.new(verb, path, body, params) }

  describe '.new' do
    let(:object) { described_class }

    subject { object.new(*arguments) }

    let(:verb)   { double('Verb')   }
    let(:path)   { '/some/path'     }
    let(:params) { double('Params') }
    let(:body)   { double('Body')   }

    context 'with two args' do
      let(:arguments) { [verb, path] }

      its(:verb)   { should be(verb) }
      its(:path)   { should be(path) }
      its(:body)   { should be(described_class::EMPTY_HASH) }
      its(:params) { should be(described_class::EMPTY_HASH) }
    end

    context 'with three args' do
      let(:arguments) { [verb, path, body] }

      its(:verb)   { should be(verb) }
      its(:path)   { should be(path) }
      its(:body)   { should be(body) }
      its(:params) { should be(described_class::EMPTY_HASH) }
    end

    context 'with four args' do
      let(:arguments) { [verb, path, body, params] }

      its(:verb)   { should be(verb)   }
      its(:path)   { should be(path)   }
      its(:body)   { should be(body)   }
      its(:params) { should be(params) }
    end
  end

  describe '#run' do

    subject { object.run(connection) }

    let(:verb)   { :get }
    let(:path)   { '/some/random/path' }
    let(:body)   { { 'foo' => 'bar' } }
    let(:params) { { 'baz' => 'buz' } }

    let(:response_status)  { double('Status') }
    let(:response_headers) { {}               }
    let(:response_body)    { double('Body')   }

    let(:connection) do
      Faraday.new do |builder|
        builder.adapter :test, stubs
      end
    end

    let(:stubs) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/some/random/path') do |env|
          env.fetch(:request_headers).fetch('Content-Type').should eql('application/json; charset=UTF-8')
          env.fetch(:method).should be(:get)
          env.fetch(:params).should eql(params)
          env.fetch(:url).should eql(URI.parse('http:/some/random/path?baz=buz'))
          env.fetch(:body).should eql('{"foo":"bar"}')
          [response_status, response_headers, response_body]
        end
      end
    end

    its(:status)  { should  be(response_status)                               }
    its(:headers) { should eql(Faraday::Utils::Headers.new(response_headers)) }
    its(:body)    { should  be(response_body)                                 }
  end

  describe '#log_string' do

    subject { object.log_string }

    let(:verb)   { :get }
    let(:path)   { '/some/random/path' }
    let(:body)   { { 'foo' => 'bar' } }
    let(:params) { { 'baz' => 'buz' } }

    it { should eql('GET /some/random/path : {"baz"=>"buz"} : {"foo"=>"bar"}') }
  end

end
