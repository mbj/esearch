# encoding: UTF-8

require 'spec_helper'

describe Esearch::Command::Status, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:get, '/foo/_status', {}, {})
  end

  expect_presenter(Esearch::Presenter::Status)
end
