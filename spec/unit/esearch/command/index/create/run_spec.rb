require 'spec_helper'

describe Esearch::Command::Index::Create, '.run' do
  subject { object.run(context, settings) }

  let(:object)   { described_class  }
  let(:settings) { mock('Settings') }

  let(:expected_request) do
    Esearch::Request.new(:put, '/foo', settings, {})
  end
 
  expect_presenter(Esearch::Presenter::Index::Create)
end
