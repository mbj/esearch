require 'spec_helper'

describe Esearch::Connection, '#run' do
  subject { object.run(request) }

  let(:object) { described_class.new(connection, logger) }

  let(:connection) { double('Connection')                               }
  let(:logger)     { DummyLogger.new                                    }
  let(:request)    { double('Request', log_string: 'the-logged-string') }
  let(:response)   { double('Response', status: 200)                    }

  class DummyLogger
    attr_reader :messages

    def initialize
      @messages = []
    end

    def debug
      @messages << yield
    end
  end

  before do
    request.should_receive(:run).with(connection).and_return(response)
  end

  it { should be(response) }

  it 'should log requests' do
    subject
    logger.messages.should eql(%w(the-logged-string 200))
  end

end
