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
  end

  def self.included(descendant)
    descendant.extend(ClassMethods)
  end
end

RSpec.configure do |config|
  config.include(CommandHelper)
end
