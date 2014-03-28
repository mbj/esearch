require 'spec_helper'

describe Esearch::Command::Exist, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:head, '/foo', {}, {})
  end

  before do
    connection.should_receive(:run).with(expected_request).and_return(response)
  end

  let(:context)    { double('Context', connection: connection, path: Pathname.new('/foo')) }
  let(:connection) { double('Connection')                                                        }

  let(:headers)    { {'content-type' => 'application/json; charset=UTF-8'} }
  let(:response)   { double('Response', :frozen? => true, status: status, headers: headers, body: '{}') }

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
