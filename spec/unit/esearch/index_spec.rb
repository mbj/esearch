require 'spec_helper'

describe Esearch::Index do
  let(:object)     { described_class.new(connection, index_name) }
  let(:connection) { double('Connection')                        }
  let(:index_name) { 'foo'                                       }

  describe '#create' do
    subject { object.create(settings) }

    let(:settings)           { { my: :settings } }
    let(:expected_arguments) { [settings]        }

    expect_to_run_command(Esearch::Command::Index::Create)
  end

  describe '#delete' do
    subject { object.delete }

    let(:expected_arguments) { [] }

    expect_to_run_command(Esearch::Command::Index::Delete)
  end

  describe '#path' do
    subject { object.path }

    it { should eql(Pathname.new('/foo')) }

    it_should_behave_like 'an idempotent method'
  end

  describe '#type' do
    subject { object.type(name) }

    let(:name) { 'bar' }

    it { should eql(Esearch::Type.new(object, name)) }
  end
end
