require 'spec_helper'

describe Elasticsearch::Connection,'#slice_size' do
  subject { object.slice_size }

  let(:object)  { described_class.new(uri,options) }
  let(:options) { {}                               }
  let(:uri)     { 'http://example.com'             }

  context 'when options are containing a slice size' do
    let(:slice_size) { mock('Slice Length') }

    before { options[:slice_size] = slice_size }

    it_should_behave_like 'an idempotent method'

    it { should be(slice_size) }
  end

  context 'when options are missing a slice size' do
    it 'should return 100' do
      should be(100)
    end

    it_should_behave_like 'an idempotent method'
  end
end
