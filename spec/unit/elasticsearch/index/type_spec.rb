require 'spec_helper'

describe Elasticsearch::Index, '#type' do
  subject { object.type(name) }

  let(:object)     { described_class.new(connection, index_name) }
  let(:connection) { mock('Connection')                          }
  let(:index_name) { 'foo'                                       }
  let(:name)       { 'bar'                                       }

  it { should eql(Elasticsearch::Type.new(object, name)) }
end
