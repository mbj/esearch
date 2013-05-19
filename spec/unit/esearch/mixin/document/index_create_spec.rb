require 'spec_helper'

describe Esearch::Mixin::Document, '#index_create' do

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Esearch::Mixin::Document
    end
  end

  context 'with one arg' do
    subject { object.index_create(document) }
    let(:document) { mock('Document') }

    let(:expected_arguments) { [document, {}] }

    expect_to_run_command(Esearch::Command::Document::Index::Create)
  end

  context 'with two args' do
    subject { object.index_create(document, options) }
    let(:document) { mock('Document') }
    let(:options)  { mock('Options') }

    let(:expected_arguments) { [document, options] }

    expect_to_run_command(Esearch::Command::Document::Index::Create)
  end
end
