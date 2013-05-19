require 'spec_helper'

describe Esearch::Index, '#type' do
  subject { object.type(name) }

  let(:object)     { described_class.new(connection, index_name) }
  let(:connection) { mock('Connection')                          }
  let(:index_name) { 'foo'                                       }
  let(:name)       { 'bar'                                       }

  it { should eql(Esearch::Type.new(object, name)) }
end
