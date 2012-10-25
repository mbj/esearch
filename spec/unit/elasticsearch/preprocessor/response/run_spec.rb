require 'spec_helper'

describe Elasticsearch::Preprocessor::Response,'#run' do
  subject { object.run }

  let(:object) { described_class.new(env) }


  let(:env) do
    {
      :logger => logger,
      :method => method,
      :request => options,
      :status => status,
      :response_headers => response_headers,
      :body => body
    }
  end

  let(:options) { {} }

  let(:body) { '{"foo":"bar"}' }
  let(:method) { :get }

  let(:logger) { ::Elasticsearch::NullLogger }

  let(:status) { 200 }
  let(:response_headers) { { 'content-type' => content_type } }
  let(:content_type) { 'application/json; charset=UTF-8' }

  it_should_behave_like 'a command method'

  context 'when body should be converted from json' do
    context 'and content type is json' do
      it 'should convert body from json' do
        subject
        env[:body].should == { 'foo' => 'bar' }
      end
    end

    context 'and content type is NOT json' do
      let(:content_type) { 'text/plain' }

      it 'should raise error' do
        expect { subject }.to raise_error(Adapter::Elasticsearch::ProtocolError,'Expected json content type but got: "text/plain"')
      end
    end
  end

  context 'when many status codes are expected' do
    before do
      options[:expect_status] = [200,400]
    end

    context 'and status code NOT matches an expected status' do
      let(:body)   { 'error' }
      let(:status) { 201 }

      it 'should raise error' do
        expect { subject }.to raise_error(Adapter::Elasticsearch::RemoteError,'error')
      end
    end

    context 'and status code matches expected status' do
      it 'should not raise exception' do
        subject
      end
    end
  end

  context 'when single status code is expected' do
    before do
      options[:expect_status] = 201
    end

    context 'and status code NOT matches expected status' do
      let(:body)   { 'error' }
      let(:status) { 200 }

      it 'should raise error' do
        expect { subject }.to raise_error(Adapter::Elasticsearch::RemoteError,'error')
      end
    end

    context 'and status code matches expected status' do
      let(:status) { 201 }
      it 'should not raise exception' do
        subject
      end
    end
  end

  context 'when no status code is ecplictly expected' do
    before do
      options.delete(:expect_status)
    end

    context 'when status code equals default ecpectation' do
      it 'should NOT raise error' do
        subject
      end
    end

    context 'when status code not equals default ecpectation' do
      let(:status) { 404 }

      it 'should raise error' do
        expect { subject }.to raise_error(Adapter::Elasticsearch::RemoteError,'{"foo":"bar"}')
      end
    end
  end

  context 'with logger present' do
    it 'should log response' do
      logger.should_receive(:debug).with('200')
      subject
    end
  end
end

