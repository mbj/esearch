require 'spec_helper'

describe Elasticsearch::Result,'#documents' do
  subject { object.documents }

  let(:object)   { described_class.new(data)        }
  let(:data)     { { 'hits' => { 'hits' => hits } } }

  let(:hits) do
    [
      { 'fields' => { 'id' => 1 } },
      { 'fields' => { 'id' => 2 } }
    ]
  end

  it_should_behave_like 'an idempotent method'

  it 'should return documents' do
    should == hits.map { |hit| hit.fetch('fields') }
  end
end
