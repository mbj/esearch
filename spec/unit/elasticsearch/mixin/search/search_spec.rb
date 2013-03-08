require 'spec_helper'

describe Elasticsearch::Mixin::Search, '#search' do
  subject { object.search(query) }

  let(:object) { class_under_test.new(connection) }

  let(:class_under_test) do
    Class.new do
      include Concord.new(:connection), Elasticsearch::Mixin::Search
    end
  end

  let(:query) { mock('Query') }
  let(:expected_arguments) { [query] }

  expect_to_run_command(Elasticsearch::Command::Search)
end
