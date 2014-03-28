require 'spec_helper'

describe Esearch::Command::Index::Delete, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:delete, '/foo', {}, {})
  end

  expect_presenter(Esearch::Presenter::Index::Delete)
end
