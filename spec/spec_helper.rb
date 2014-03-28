# encoding: utf-8
require 'esearch'
require 'devtools'
Devtools.init_spec_helper

module CommandHelper
  module ClassMethods

    def expect_to_run_command(command)
      let(:connection) { double('Connection') }
      let(:result)     { double('Result')     }

      before do
        command.should_receive(:run).with(object, *expected_arguments).and_return(result)
      end

      it { should be(result) }
    end

    def setup_connection
      let(:context)    { double('Context', connection: connection, path: Pathname.new('/foo')) }
      let(:connection) { double('Connection')                                                        }

      let(:headers)    { {'content-type' => 'application/json; charset=UTF-8'} }
      let(:response)   { double('Response', :frozen? => true, status: status, headers: headers, body: '{}') }

      let(:status)     { 200 }

      before do
        connection.should_receive(:run).with(expected_request).and_return(response)
      end
    end

    def expect_exception(exception)
      setup_connection

      yield if block_given?

      it 'should raise error' do
        expect { subject }.to raise_error(exception)
      end
    end

    def expect_result(result)
      setup_connection

      yield if block_given?

      it { should eql(result) }
    end

    def expect_presenter(presenter, &block)
      expect_result(presenter.new({}), &block)
    end
  end

  def self.included(descendant)
    descendant.extend(ClassMethods)
  end
end


RSpec.configure do |config|
  config.include(CommandHelper)
end
