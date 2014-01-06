require 'spec_helper'

describe Esearch::Cluster, '#indices' do
  subject { object.indices(names) }

  let(:object)     { described_class.new(connection) }
  let(:connection) { double('Connection')            }
  let(:names)      { %w(foo bar)                     }

  it { should eql(Esearch::Indices.new(connection, names)) }
end
