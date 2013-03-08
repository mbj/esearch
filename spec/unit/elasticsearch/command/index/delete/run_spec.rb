require 'spec_helper'

describe Elasticsearch::Command::Index::Delete, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:delete, '/foo', {}, {})
  end
 
  expect_presenter(Elasticsearch::Presenter::Index::Delete)
end
