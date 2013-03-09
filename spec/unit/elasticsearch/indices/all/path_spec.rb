require 'spec_helper'

describe Elasticsearch::Indices::All, '#path' do
  subject { object.path }

  let(:object) { described_class.new(connection) }
  let(:connection) { mock('Connection') }

  it { should eql(Pathname.new('/_all')) }

  it_should_behave_like 'an idempotent method'
end
