require 'spec_helper'

describe Elasticsearch::Result, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)   { described_class.new(data)        }
  let(:yields)   { []                               }
  let(:data)     { { 'hits' => { 'hits' => hits } } }

  it_should_behave_like 'an #each method'

  let(:hits) do
    [
      { 'fields' => { 'id' => 1 } },
      { 'fields' => { 'id' => 2 } }
    ]
  end

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ { 'id' => 1 }, { 'id' => 2 } ])
  end
end
