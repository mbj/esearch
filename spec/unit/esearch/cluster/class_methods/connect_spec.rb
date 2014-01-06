require 'spec_helper'

describe Esearch::Cluster, '.connect' do
  subject { object.connect(*arguments) }

  let(:object)     { described_class      }
  let(:connection) { double('Connection') }

  let(:arguments) { [:foo, :bar] }

  before do
    Esearch::Connection.should_receive(:build).with(:foo, :bar).and_return(connection)
  end

  it { should eql(described_class.new(connection)) }
end
