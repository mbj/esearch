require 'spec_helper'

describe Elasticsearch::Command::Document::Get, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, '/foo', {}, {})
  end
 
  context 'with status 200' do
    expect_presenter(Elasticsearch::Presenter::Document::Get)
  end
 
  context 'with status 404' do
    expect_result(nil) do
      let(:status) { 404 }
    end
  end
 
  context 'with status 500' do
    expect_exception(Elasticsearch::ProtocolError) do
      let(:status) { 500 }
    end
  end
end
