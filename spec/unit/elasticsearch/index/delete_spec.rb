require 'spec_helper'

describe Elasticsearch::Index, '#delete' do
  subject { object.delete }

  let(:object)             { described_class.new(connection, index_name) }
  let(:index_name)         { 'foo' }
  let(:expected_arguments) { [] }

  expect_to_run_command(Elasticsearch::Command::Index::Delete)
end
