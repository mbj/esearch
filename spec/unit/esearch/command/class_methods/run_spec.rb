require 'spec_helper'

describe Esearch::Command, '.run' do
  subject { object.run(*arguments) }

  let(:object) { described_class }

  let(:instance)  { double('Instance', result: result) }
  let(:result)    { double('Result')                      }
  let(:arguments) { [:foo, :bar]                          }

  it 'should instantiate object and return result' do
    described_class.should_receive(:new).with(*arguments).and_return(instance)
    should be(result)
  end
end
