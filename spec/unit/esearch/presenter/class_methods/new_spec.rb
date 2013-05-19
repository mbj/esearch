require 'spec_helper'

describe Esearch::Presenter, '.new' do
  let(:object) { class_under_test }

  subject { object.new(raw) }

  let(:value) { mock('Value') }

  class DummyPresenter
    include Concord.new(:raw) 
  end

  context 'with exposed tagged collection' do
    let(:raw) { { 'foo' => { 'bar' => { 'baz' => 'bor' } } } }

    let(:class_under_test) do
      Class.new(described_class) do
        expose_tagged_collection(:foo, DummyPresenter)
      end
    end

    its(:foo) { should eql([DummyPresenter.new('baz' => 'bor', 'name' => 'bar')]) }
  end

  context 'with exposed primitive' do
    let(:raw) { { 'foo' => value } }

    let(:class_under_test) do
      Class.new(described_class) do
        expose_primitive :foo
      end
    end

    its(:foo) { should be(value) }
  end
end
