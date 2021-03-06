# encoding: UTF-8

require 'spec_helper'

describe Esearch::Presenter::Hit, '#source' do
  subject { object.source }

  let(:object) { described_class.new(raw) }
  let(:value)  { double('Value')          }

  context 'when _source is present' do
    let(:raw) { { '_source' => value } }

    it { should be(value) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when _source is NOT present' do
    let(:raw) { {} }

    it { should be(nil) }

    it_should_behave_like 'an idempotent method'
  end
end
