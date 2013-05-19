require 'spec_helper'

describe Esearch::Command::Document::Index::Create, '.run' do
  subject { object.run(context, document, options) }

  let(:object)   { described_class  }
  let(:document) { mock('Document') }
  let(:options)  { { :foo => :bar } }

  let(:expected_request) do
    Esearch::Request.new(:post, '/foo', document, { :foo => :bar, :op_type => :create })
  end
 
  expect_presenter(Esearch::Presenter::Document::Operation::Index) do
    let(:status) { 201 }
  end
end
