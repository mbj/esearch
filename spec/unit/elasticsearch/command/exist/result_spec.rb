require 'spec_helper'

describe Elasticsearch::Command::Exist, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:head, '/foo', {}, {})
  end

  before do
    connection.should_receive(:run).with(expected_request).and_return(response)
  end

  let(:context)    { mock('Context', :connection => connection, :path => Pathname.new('/foo')) }
  let(:connection) { mock('Connection')                                                        }

  let(:headers)    { {'content-type' => 'application/json; charset=UTF-8'} }
  let(:response)   { mock('Response', :frozen? => true, :status => status, :headers => headers, :body => '{}') }

  context 'with status 200' do
    let(:status)     { 200 }
    it { should be(true) }
  end

  context 'with status 404' do
    let(:status)     { 404 }
    it { should be(false) }
  end

  context 'with other status' do
    let(:status) { 500 }

    it 'should raise error' do
      expect { subject }.to raise_error
    end
  end
end
