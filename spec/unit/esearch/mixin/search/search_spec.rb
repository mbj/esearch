require 'spec_helper'

describe Esearch::Mixin::Search, '#search' do
  subject { object.search(query) }

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Esearch::Mixin::Search
    end
  end

  let(:query) { double('Query') }
  let(:expected_arguments) { [query] }

  expect_to_run_command(Esearch::Command::Search)
end
