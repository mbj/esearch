require 'spec_helper'

describe Elasticsearch::Cluster, '#index' do
  subject { object.index(name) }

  let(:object)     { described_class.new(connection) }
  let(:connection) { mock('Connection')              }
  let(:name)       { 'foo'                           }

  it { should eql(Elasticsearch::Index.new(connection, name)) }
end
