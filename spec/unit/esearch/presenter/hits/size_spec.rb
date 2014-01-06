require 'spec_helper'

describe Esearch::Presenter::Hits, '#size' do
  subject { object.size }

  let(:object) { described_class.new(raw)           }
  let(:size)   { double('Size')                     }
  let(:raw)    { { 'hits' => double(:size => size)} }

  it { should be(size) }

  it_should_behave_like 'an idempotent method'
end
