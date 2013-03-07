require 'spec_helper'

describe Elasticsearch::Index, '#create' do
  subject { object.create(settings) }

  let(:object)             { described_class.new(connection, index_name) }
  let(:index_name)         { 'foo'                }
  let(:settings)           { { :my => :settings } }
  let(:expected_arguments) { [settings]           }

  expect_to_run_command(Elasticsearch::Command::Index::Create)
end
