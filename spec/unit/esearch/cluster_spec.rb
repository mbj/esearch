require 'spec_helper'

describe Esearch::Cluster do
  let(:object)     { described_class.new(connection) }

  describe '.connect' do
    subject { object.connect(*arguments) }

    let(:object)     { described_class      }
    let(:connection) { double('Connection') }

    let(:arguments) { [:foo, :bar] }

    before do
      Esearch::Connection.should_receive(:build).with(:foo, :bar).and_return(connection)
    end

    it { should eql(described_class.new(connection)) }

  end

  describe '#health' do
    subject { object.health }

    let(:expected_arguments) { [{}] }

    expect_to_run_command(Esearch::Command::Cluster::Health)
  end

  describe '#index' do
    subject { object.index(name) }

    let(:object)     { described_class.new(connection) }
    let(:connection) { double('Connection')            }
    let(:name)       { 'foo'                           }

    it { should eql(Esearch::Index.new(connection, name)) }
  end

  describe '#indices' do
    subject { object.indices(names) }

    let(:object)     { described_class.new(connection) }
    let(:connection) { double('Connection')            }
    let(:names)      { %w(foo bar)                     }

    it { should eql(Esearch::Indices.new(connection, names)) }
  end

  describe '#path' do
    subject { object.path }

    let(:object) { described_class.new(connection) }

    let(:connection) { double('Connection') }

    it { should eql(Pathname.new('/')) }
  end
end
