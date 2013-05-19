require 'spec_helper'

describe Esearch::Command::Index::Refresh, '.run' do
  subject { object.run(context) }

  let(:object)   { described_class  }

  let(:expected_request) do
    Esearch::Request.new(:post, '/foo/_refresh', {}, {})
  end
 
  expect_presenter(Esearch::Presenter::Index::Refresh)
end
