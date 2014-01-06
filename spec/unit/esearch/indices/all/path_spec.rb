require 'spec_helper'

describe Esearch::Indices::All, '#path' do
  subject { object.path }

  let(:object)     { described_class.new(connection) }
  let(:connection) { double('Connection')            }

  it { should eql(Pathname.new('/_all')) }

  it_should_behave_like 'an idempotent method'
end
