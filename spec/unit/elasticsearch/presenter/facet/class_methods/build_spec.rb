require 'spec_helper'

describe Elasticsearch::Presenter::Facet, '.build' do
  subject { object.build(raw) }

  let(:object) { described_class }

  context 'when type is "terms"' do
    let(:raw) { { '_type' => 'terms' } }
    it { should eql(Elasticsearch::Presenter::Facet::Terms.new(raw)) }
  end

  context 'when type is "range"' do
    let(:raw) { { '_type' => 'range' } }
    it { should eql(Elasticsearch::Presenter::Facet::Range.new(raw)) }
  end

  context 'with unknown type' do
    let(:raw) { { '_type' => 'foo' } }

    it 'should raise error' do
      expect { subject }.to raise_error('Facet with type "foo" is not known')
    end
  end

end
