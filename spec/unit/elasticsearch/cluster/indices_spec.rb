require 'spec_helper'

describe Elasticsearch::Cluster, '#indices' do
  subject { object.indices(names) }

  let(:object)     { described_class.new(connection) }
  let(:connection) { mock('Connection')              }
  let(:names)      { %w(foo bar)                     }

  it { should eql(Elasticsearch::Indices.new(connection, names)) }
end
