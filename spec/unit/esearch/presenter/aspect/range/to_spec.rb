# encoding: UTF-8

require 'spec_helper'

describe Esearch::Presenter::Aspect::Range, '#to' do
  subject { object.to }

  let(:object) { described_class.new(raw) }
  let(:value)  { double('Value')          }

  context 'when _source is present' do
    let(:raw) { { 'to' => value } }

    it { should be(value) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when _source is NOT present' do
    let(:raw) { {} }

    it { should be(nil) }

    it_should_behave_like 'an idempotent method'
  end
end
