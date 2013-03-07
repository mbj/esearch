require 'spec_helper'

describe Elasticsearch::Cluster, '.connect' do
  subject { object.connect(*arguments) }

  let(:object)     { described_class    }
  let(:connection) { mock('Connection') }

  let(:arguments) { [:foo, :bar] }
  
  before do
    Elasticsearch::Connection.should_receive(:build).with(:foo, :bar).and_return(connection)
  end

  it { should eql(described_class.new(connection)) }
end
