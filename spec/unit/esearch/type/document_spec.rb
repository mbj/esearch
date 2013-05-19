require 'spec_helper'

describe Esearch::Type, '#document' do
  subject { object.document(id) }

  let(:object)    { described_class.new(index, type_name) }
  let(:index)     { mock('Index')                         }
  let(:type_name) { 'foo'                                 }
  let(:id)        { '1'                                   }

  it { should eql(Esearch::Document.new(object, id)) }
end
