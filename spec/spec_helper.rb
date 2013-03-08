# encoding: utf-8
require 'elasticsearch'
require 'devtools'
Devtools.init_spec_helper

module CommandHelper
  module ClassMethods
    def expect_to_run_command(command)

      let(:connection) { mock('Connection') }
      let(:result)     { mock('Result')     }

      before do
        command.should_receive(:run).with(object, *expected_arguments).and_return(result)
      end

      it { should be(result) }
    end

    def expect_presenter(presenter) 
      let(:context)    { mock('Context', :connection => connection, :path => Pathname.new('/foo')) }
      let(:connection) { mock('Connection')                                                        }

      let(:headers)    { {'content-type' => 'application/json; charset=UTF-8'} }
      let(:response)   { mock('Response', :frozen? => true, :status => status, :headers => headers, :body => '{}') }

      let(:status)     { 200 }

      yield if block_given?

      before do
        connection.should_receive(:run).with(expected_request).and_return(response)
      end

      it { should eql(presenter.new({})) }
    end
  end

  def self.included(descendant)
    descendant.extend(ClassMethods)
  end
end


RSpec.configure do |config|
  config.include(CommandHelper)
end
