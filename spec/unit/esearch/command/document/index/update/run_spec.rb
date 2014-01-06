require 'spec_helper'

describe Esearch::Command::Document::Index::Update, '.run' do
  subject { object.run(context, document, options) }

  let(:object)   { described_class    }
  let(:document) { double('Document') }
  let(:options)  { { :foo => :bar }   }

  let(:expected_request) do
    Esearch::Request.new(:post, '/foo', document, { :foo => :bar, :op_type => :index })
  end

  expect_presenter(Esearch::Presenter::Document::Operation::Index)
end
