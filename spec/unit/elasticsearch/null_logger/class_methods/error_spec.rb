require 'spec_helper'

describe Elasticsearch::NullLogger,'#error' do
  let(:method) { :error }

  it_should_behave_like 'a null logger method'
end
