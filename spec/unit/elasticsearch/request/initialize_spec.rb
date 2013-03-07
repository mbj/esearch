require 'spec_helper'

describe Elasticsearch::Request, '.new' do
  let(:object) { described_class }

  subject { object.new(*arguments) }

  let(:verb)   { mock('Verb')   }
  let(:path)   { '/some/path'   }
  let(:params) { mock('Params') }
  let(:body)   { mock('Body')   }

  context 'with two args' do
    let(:arguments) { [ verb, path ] }

    its(:verb)   { should be(verb) }
    its(:path)   { should be(path) }
    its(:body)   { should be(described_class::EMPTY_HASH) }
    its(:params) { should be(described_class::EMPTY_HASH) }
  end

  context 'with three args' do
    let(:arguments) { [ verb, path, body ] }

    its(:verb)   { should be(verb) }
    its(:path)   { should be(path) }
    its(:body)   { should be(body) }
    its(:params) { should be(described_class::EMPTY_HASH) }
  end

  context 'with four args' do
    let(:arguments) { [ verb, path, body, params ] }

    its(:verb)   { should be(verb)   }
    its(:path)   { should be(path)   }
    its(:body)   { should be(body)   }
    its(:params) { should be(params) }
  end
end
