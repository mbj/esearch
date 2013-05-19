require 'spec_helper'

describe Esearch::Mixin::Exist, '#exist?' do
  subject { object.exist? }

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Esearch::Mixin::Exist
    end
  end

  let(:expected_arguments) { [] }
  expect_to_run_command(Esearch::Command::Exist)
end
