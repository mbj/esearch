require 'spec_helper'

describe Elasticsearch::Command::Index::Refresh, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:post, '/foo/_refresh', {}, {})
  end
 
  expect_presenter(Elasticsearch::Presenter::Index::Refresh)
end
