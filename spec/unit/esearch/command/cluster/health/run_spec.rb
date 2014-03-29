# encoding: UTF-8

require 'spec_helper'

describe Esearch::Command::Cluster::Health, '.run' do
  subject { object.run(context, options) }

  let(:object)   { described_class   }
  let(:options)  { double('Options') }

  let(:expected_request) do
    Esearch::Request.new(:get, '/_cluster/health', {}, options)
  end

  expect_presenter(Esearch::Presenter::Cluster::Health)
end
