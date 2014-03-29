# encoding: UTF-8

require 'spec_helper'

describe Esearch::Indices::All do
  let(:object)     { described_class.new(connection) }
  let(:connection) { double('Connection')            }

  describe '#path' do
    subject { object.path }

    it { should eql(Pathname.new('/_all')) }

    it_should_behave_like 'an idempotent method'
  end
end
