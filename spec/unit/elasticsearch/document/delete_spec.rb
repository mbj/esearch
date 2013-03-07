require 'spec_helper'

describe Elasticsearch::Document, '#delete' do
  subject { object.delete}

  let(:object)             { described_class.new(type, id) }
  let(:type)               { mock('Type')                  }
  let(:id)                 { '1'                           }
  let(:expected_arguments) { []                            }

  expect_to_run_command(Elasticsearch::Command::Document::Delete)
end
