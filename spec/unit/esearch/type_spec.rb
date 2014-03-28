require 'spec_helper'

describe Esearch::Type do
  let(:object)     { described_class.new(index, type_name)   }
  let(:index)      { double('Index', connection: connection) }
  let(:connection) { double('Connection')                    }
  let(:type_name)  { double('Type Name')                     }

  describe '#connection' do
    subject { object.connection }

    it { should be(connection) }

    it_should_behave_like 'an idempotent method'
  end

  describe '#document' do
    subject { object.document(id) }

    let(:id)        { double('ID') }

    it { should eql(Esearch::Document.new(object, id)) }
  end

  describe '#path' do
    let(:type_name) { 'type-foo' }
    let(:index)     { double('Index', path: Pathname.new('a-index')) }

    subject { object.path }

    it { should eql(Pathname.new('a-index/type-foo')) }

    it_should_behave_like 'an idempotent method'
  end
end
