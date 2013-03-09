require 'spec_helper'

describe Elasticsearch::Presenter::Hits, '#size' do
  subject { object.size }

  let(:object) { described_class.new(raw) }
  let(:size)   { mock('Size') }
  let(:raw)    { { 'hits' => mock(:size => size)} }

  it { should be(size) }

  it_should_behave_like 'an idempotent method'
end
