require 'spec_helper'

describe Elasticsearch::Type, '#connection' do
  subject { object.connection }

  let(:object)     { described_class.new(index, type_name)    }
  let(:index)      { mock('Index', :connection => connection) }
  let(:connection) { mock('Connection')                       }
  let(:type_name)  { mock('Type Name')                        }

  it { should be(connection) }

  it_should_behave_like 'an idempotent method'
end

