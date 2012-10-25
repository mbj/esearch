require 'spec_helper'

describe Elasticsearch::Result,'#size' do
  subject { object.size }

  let(:object)   { described_class.new(data)        }
  let(:data)     { { 'hits' => { 'hits' => hits } } }

  let(:hits) do
    [
      { 'fields' => { 'id' => 1 } },
      { 'fields' => { 'id' => 2 } }
    ]
  end

  it_should_behave_like 'an idempotent method'

  it 'should return number of hits' do
    should equal(2)
  end
end
