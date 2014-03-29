# encoding: UTF-8

require 'spec_helper'

describe Esearch::Mixin::Index, '#refresh' do
  subject { object.refresh }

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Esearch::Mixin::Index
    end
  end

  let(:expected_arguments) { [] }
  expect_to_run_command(Esearch::Command::Index::Refresh)
end
