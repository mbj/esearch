require 'spec_helper'

describe Esearch::Document, '#get' do
  subject { object.get}

  let(:object)             { described_class.new(type, id) }
  let(:type)               { double('Type')                }
  let(:id)                 { '1'                           }
  let(:expected_arguments) { []                            }

  expect_to_run_command(Esearch::Command::Document::Get)
end
