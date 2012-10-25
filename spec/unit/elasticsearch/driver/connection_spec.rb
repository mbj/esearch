require 'spec_helper'

describe Elasticsearch::Driver,'#connection' do
  subject { object.connection }

  let(:object)  { described_class.new(uri,options) }
  let(:options) { {}                               }
  let(:uri)     { 'http://example.com:9200/'       }

  it_should_behave_like 'an idempotent method'

  it { should be_kind_of(Faraday::Connection) }

  its(:url_prefix) { subject.to_s.should == uri }
end
