require 'spec_helper'

describe Esearch::Command::Search, '.run' do
  subject { object.run(context, query) }

  let(:object) { described_class }
  let(:query)  { double('Query') }

  let(:expected_request) do
    Esearch::Request.new(:get, '/foo/_search', query, {})
  end

  expect_presenter(Esearch::Presenter::Search)
end
