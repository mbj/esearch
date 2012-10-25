require 'spec_helper'

describe Elasticsearch::NullLogger,'#debug' do
  let(:method) { :debug }

  it_should_behave_like 'a null logger method'
end
