require 'spec_helper'

describe Esearch::Document, '#connection' do
  subject { object.connection }

  let(:object)             { described_class.new(type, id)          }
  let(:type)               { double('Type', connection: connection) }
  let(:connection)         { double('Connection')                   }
  let(:id)                 { '1'                                    }

  it { should be(connection) }
end
