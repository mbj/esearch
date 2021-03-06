# encoding: UTF-8

require 'spec_helper'

describe Esearch::Command::Document::Delete, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:delete, '/foo', {}, {})
  end

  expect_presenter(Esearch::Presenter::Document::Operation::Delete)
end
