require 'spec_helper'

describe Elasticsearch::Command::Index::Create, '.run' do
  subject { object.run(context, settings) }

  let(:object)   { described_class  }
  let(:settings) { mock('Settings') }

  let(:expected_request) do
    Elasticsearch::Request.new(:put, '/foo', settings, {})
  end
 
  expect_presenter(Elasticsearch::Presenter::Index::Create)
end
