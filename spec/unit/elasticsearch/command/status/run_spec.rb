require 'spec_helper'

describe Elasticsearch::Command::Status, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, '/foo/_status', {}, {})
  end
 
  expect_presenter(Elasticsearch::Presenter::Status)
end
