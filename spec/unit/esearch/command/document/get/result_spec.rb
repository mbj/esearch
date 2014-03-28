require 'spec_helper'

describe Esearch::Command::Document::Get, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:get, '/foo', {}, {})
  end

  context 'with status 200' do
    expect_presenter(Esearch::Presenter::Document::Get)
  end

  context 'with status 404' do
    expect_result(nil) do
      let(:status) { 404 }
    end
  end

  context 'with status 500' do
    expect_exception(Esearch::ProtocolError) do
      let(:status) { 500 }
    end
  end
end
