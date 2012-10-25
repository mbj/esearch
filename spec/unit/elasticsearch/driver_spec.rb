require 'spec_helper'

describe Elasticsearch,'#driver' do
  subject { object.driver }

  let(:object) { described_class.new(uri,options) }

  let(:uri)     { 'http://example.com' }
  let(:options) { {} }

  it { should be_kind_of(Adapter::Elasticsearch::Driver) }

  it_should_behave_like 'an idempotent method'
end
