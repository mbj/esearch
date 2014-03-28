require 'spec_helper'

describe Esearch::Type, '#connection' do
  subject { object.connection }

  let(:object)     { described_class.new(index, type_name)      }
  let(:index)      { double('Index', connection: connection) }
  let(:connection) { double('Connection')                       }
  let(:type_name)  { double('Type Name')                        }

  it { should be(connection) }

  it_should_behave_like 'an idempotent method'
end

