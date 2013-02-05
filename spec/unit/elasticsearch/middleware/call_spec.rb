require 'spec_helper'

describe Elasticsearch::Middleware,'#call' do
  let(:object) { described_class.new(app, logger) }

  let(:app)    { mock(:App) }
  let(:logger) { mock(:Logger) }
  let(:env)    { {} }

  let(:arguments) { [app] }

  subject { object.call(env) }

  before do
    ::Elasticsearch::Preprocessor::Request.should_receive(:run).with(env)
    ::Elasticsearch::Preprocessor::Response.should_receive(:run).with(env)
    app.should_receive(:call).with(env).and_return(app)
    app.should_receive(:on_complete).and_yield
  end

  it 'should call request and response preprocessor' do
    subject
  end

  it 'should store logger in env' do
    subject
    env.should == { :logger => logger }
  end
end
