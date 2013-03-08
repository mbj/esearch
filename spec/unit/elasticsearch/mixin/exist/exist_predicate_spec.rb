require 'spec_helper'

describe Elasticsearch::Mixin::Exist, '#exist?' do
  subject { object.exist? }

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Elasticsearch::Mixin::Exist
    end
  end

  let(:expected_arguments) { [] }
  expect_to_run_command(Elasticsearch::Command::Exist)
end
