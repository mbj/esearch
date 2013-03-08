require 'spec_helper'

describe Elasticsearch::Command::Document::Index, '.run' do
  subject { object.run(context, document, options) }

  let(:object)   { described_class  }
  let(:document) { mock('Document') }
  let(:options)  { { :foo => :bar } }

  let(:expected_request) do
    Elasticsearch::Request.new(:post, '/foo', document, options)
  end

  expect_presenter(Elasticsearch::Presenter::Document::Operation::Index)
end
