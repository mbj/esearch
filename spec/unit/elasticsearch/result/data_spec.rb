require 'spec_helper'

describe Elasticsearch::Result,'#data' do
  subject { object.data }

  let(:object) { described_class.new(data) }
  let(:data)   { mock('Data') }

  it { should equal(data) }

  it_should_behave_like 'an idempotent method'
end
