require 'spec_helper'

describe Esearch::Presenter::Search do
  let(:object) { described_class.new(raw) }

  describe '#facets' do
    subject { object.facets }

    context 'with no facets' do
      let(:raw) { {} }

      it { should eql({}) }

      it_should_behave_like 'an idempotent method'
    end

    context 'with facets' do
      let(:raw) do
        {
          'facets' => {
            'foo' => { '_type' => 'terms' },
            'bar' => { '_type' => 'range' }
          }
        }
      end

      it do
        should eql(
          'foo' => Esearch::Presenter::Facet::Terms.build('_type' => 'terms'),
          'bar' => Esearch::Presenter::Facet::Range.build('_type' => 'range')
        )
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
