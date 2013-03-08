require 'spec_helper'

describe Elasticsearch::Command::Search, '.run' do
  subject { object.run(context, query) }

  let(:object) { described_class }
  let(:query)  { mock('Query') }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, '/foo/_search', query, {})
  end

  expect_presenter(Elasticsearch::Presenter::Search)
end
