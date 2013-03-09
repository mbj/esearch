require 'spec_helper'

describe Elasticsearch::Command, '#result' do
  let(:object) { class_under_test.new(context) }

  subject { object.result }

  class DummyPresenter
    include Concord.new(:raw)
  end

  let(:class_under_test) do
    Class.new(described_class) do
      const_set('PRESENTER', DummyPresenter)
      def request
        Elasticsearch::Request.new(:get, context_path)
      end
    end
  end


  let(:context)    { mock('Context', :connection => connection, :path => Pathname.new('/foo')) }
  let(:connection) { mock('Connection')                                                        }

  let(:headers)    { {'content-type' => content_type } }
  let(:content_type) { 'application/json; charset=UTF-8' }
  let(:response)   { mock('Response', :frozen? => true, :status => status, :headers => headers, :body => body) }
  let(:body)       { '{}' }

  let(:status)     { 200 }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, context.path)
  end

  before do
    connection.should_receive(:run).with(expected_request).and_return(response)
  end

  it { should eql(DummyPresenter.new({})) }

  context 'when content type is not expected' do
    let(:content_type) { 'text/plain' }

    it 'should raise error' do
      expect { subject }.to raise_error(Elasticsearch::ProtocolError, 'Expected json content type, but got: "text/plain"')
    end
  end

  context 'when status code is not expected' do
    let(:status) { 201 }

    context 'with json body' do
      it 'should raise error' do
        expect { subject }.to raise_error('expected response stati: [200] but got: 201, remote message: {}')
      end
    end

    context 'with other body' do
      let(:content_type) { 'text/plain' }
      let(:body)         { 'message'   }

      it 'should raise error' do
        expect { subject }.to raise_error('expected response stati: [200] but got: 201, remote message: message')
      end
    end
  end
end
