require 'spec_helper'

describe Esearch::Presenter::Hit, '#fields' do
  subject { object.fields }

  let(:object) { described_class.new(raw) }
  let(:value)  { double('Value')          }

  context 'when fields is present' do
    let(:raw) { { 'fields' => value } }

    it { should be(value) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when fields is NOT present' do
    let(:raw) { {} }

    it { should be(nil) }

    it_should_behave_like 'an idempotent method'
  end
end
