require 'spec_helper'

describe Elasticsearch::Preprocessor,'.run' do
  let(:object) { described_class }

  subject { object.run(env) }

  let(:env) { mock }

  let(:instance) { mock }

  it 'should instanciate preprocessor and call #run' do
    object.should_receive(:new).with(env).and_return(instance)
    instance.should_receive(:run)

    subject
  end
end
