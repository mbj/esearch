require 'spec_helper'

describe Esearch::Index, '#delete' do
  subject { object.delete }

  let(:object)             { described_class.new(connection, index_name) }
  let(:index_name)         { 'foo' }
  let(:expected_arguments) { [] }

  expect_to_run_command(Esearch::Command::Index::Delete)
end
