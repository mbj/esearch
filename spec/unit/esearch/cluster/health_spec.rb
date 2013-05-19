require 'spec_helper'

describe Esearch::Cluster, '#health' do
  subject { object.health }

  let(:object)     { described_class.new(connection) }
  let(:expected_arguments) { [{}] }

  expect_to_run_command(Esearch::Command::Cluster::Health)
end
