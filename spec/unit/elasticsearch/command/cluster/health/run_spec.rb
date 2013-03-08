require 'spec_helper'

describe Elasticsearch::Command::Cluster::Health, '.run' do
  subject { object.run(context, options) }

  let(:object)   { described_class  }
  let(:options)  { mock('Options')  }

  let(:expected_request) do
    Elasticsearch::Request.new(:get, '/_cluster/health', {}, options)
  end
 
  expect_presenter(Elasticsearch::Presenter::Cluster::Health)
end
