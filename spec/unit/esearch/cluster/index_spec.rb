require 'spec_helper'

describe Esearch::Cluster, '#index' do
  subject { object.index(name) }

  let(:object)     { described_class.new(connection) }
  let(:connection) { mock('Connection')              }
  let(:name)       { 'foo'                           }

  it { should eql(Esearch::Index.new(connection, name)) }
end
