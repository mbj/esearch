require 'spec_helper'

describe Elasticsearch::Command::Document::Get, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, '/foo', {}, {})
  end
 
  expect_presenter(Elasticsearch::Presenter::Document::Get)
end
