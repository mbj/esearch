# encoding: UTF-8

require 'spec_helper'

describe Esearch::Indices do
  let(:object)     { described_class.new(connection, names) }
  let(:connection) { double('Connection')                   }

  let(:names) { %w(foo bar) }

  describe '#path' do
    subject { object.path }

    it { should eql(Pathname.new('/foo,bar')) }

    it_should_behave_like 'an idempotent method'
  end
end
