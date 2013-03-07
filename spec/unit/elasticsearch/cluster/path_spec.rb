require 'spec_helper'

describe Elasticsearch::Cluster, '#path' do
  subject { object.path }

  let(:object) { described_class.new(connection) }

  let(:connection) { mock('Connection') }

  it { should eql(Pathname.new('/')) }
end
