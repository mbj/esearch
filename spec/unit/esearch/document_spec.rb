# encoding: UTF-8

require 'spec_helper'

describe Esearch::Document do
  let(:object)     { described_class.new(type, id)          }
  let(:type)       { double('Type', connection: connection) }
  let(:connection) { double('Connection')                   }
  let(:id)         { '1'                                    }

  describe '#connection' do
    subject { object.connection }

    it { should be(connection) }
  end

  describe '#delete' do
    subject { object.delete }

    let(:expected_arguments) { [] }

    expect_to_run_command(Esearch::Command::Document::Delete)
  end

  describe '#get' do
    subject { object.get }

    let(:expected_arguments) { [] }

    expect_to_run_command(Esearch::Command::Document::Get)
  end

  describe '#path' do
    subject { object.path }

    let(:type) { double('Type', connection: connection, path: Pathname.new('a-index/b-type')) }

    let(:id)   { 'c-id' }

    it { should eql(Pathname.new('a-index/b-type/c-id')) }

    it_should_behave_like 'an idempotent method'
  end
end
