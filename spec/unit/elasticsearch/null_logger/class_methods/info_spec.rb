require 'spec_helper'

describe Elasticsearch::NullLogger,'#info' do
  let(:method) { :info }

  it_should_behave_like 'a null logger method'
end
