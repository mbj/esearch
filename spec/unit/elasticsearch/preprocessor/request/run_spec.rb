require 'spec_helper'

describe Elasticsearch::Preprocessor::Request,'#run' do
  let(:object) { described_class.new(env) }

  subject { object.run }

  let(:logger) { ::Elasticsearch::NullLogger }

  let(:body) { { :foo => 'bar'} }

  let(:env) do
    {
      :logger => logger,
      :url => "http://example.com/index/_search",
      :method => :get,
      :body => body,
      :request => options
    }
  end

  let(:options) { {} }

  it_should_behave_like 'a command method'

  context 'when body conversion to json was requested' do
    context 'and body is present' do
      it 'should convert body to json' do
        subject
        env[:body].should == '{"foo":"bar"}'
      end
    end

    context 'and body is NOT present' do
      let(:body) { nil }
      it 'should not not change body' do
        subject
        env[:body].should be_nil
      end
    end
  end

  context 'when body conversion to json was NOT requested' do
    before do
      options[:convert_json] = false
    end

    it 'should NOT convert body to json' do
      subject
      env[:body].should == body
    end
  end

  context 'with logger present' do
    it 'should log request' do
      logger.should_receive(:debug).with('GET http://example.com/index/_search {"foo":"bar"}')
      subject
    end
  end
end

