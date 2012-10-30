require 'spec_helper'

shared_examples_for 'a null logger method' do
  subject { object.public_send(method,message) }

  let(:object)  { Elasticsearch::NullLogger }
  let(:message) { mock('Message')           }

  it_should_behave_like 'a command method'
end
