require 'spec_helper'

describe Esearch::Index, '#create' do
  subject { object.create(settings) }

  let(:object)             { described_class.new(connection, index_name) }
  let(:index_name)         { 'foo'                }
  let(:settings)           { { :my => :settings } }
  let(:expected_arguments) { [settings]           }

  expect_to_run_command(Esearch::Command::Index::Create)
end
