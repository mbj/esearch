require 'spec_helper'

describe Elasticsearch::Document, '#connection' do
  subject { object.connection }

  let(:object)             { described_class.new(type, id)           }
  let(:type)               { mock('Type', :connection => connection) }
  let(:connection)         { mock('Connection')                      }
  let(:id)                 { '1'                                     }

  it { should be(connection) }
end
