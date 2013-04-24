require 'spec_helper'

describe Elasticsearch::Request, '#run' do
  let(:object) { described_class.new(verb, path, body, params) }

  subject { object.run(connection) }

  let(:verb)   { :get }
  let(:path)   { '/some/random/path' }
  let(:body)   { { 'foo' => 'bar' } }
  let(:params) { { 'baz' => 'buz' } }

  let(:response_status)  { mock('Status') }
  let(:response_headers) { {}             }
  let(:response_body)    { mock('Body')   }

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
        [ response_status, response_headers, response_body ]
      end
    end
  end

  its(:status)  { should  be(response_status)                               }
  its(:headers) { should eql(Faraday::Utils::Headers.new(response_headers)) }
  its(:body)    { should  be(response_body)                                 }
end
