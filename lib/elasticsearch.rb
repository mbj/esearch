require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'composition'
require 'abstract_type'
require 'null_logger'
require 'response'

# Library namespace
module Elasticsearch
  # Error raised when node signals an exception
  class RemoteError < StandardError; end
  # Error raised when protocol is violated
  class ProtocolError < StandardError; end
end

require 'elasticsearch/connection'
require 'elasticsearch/result'
require 'elasticsearch/result/hit'
require 'elasticsearch/result/hits'
require 'elasticsearch/result/aspect'
require 'elasticsearch/result/aspect/term'
require 'elasticsearch/result/aspect/range'
require 'elasticsearch/result/facet'
require 'elasticsearch/index'
require 'elasticsearch/operation'
require 'elasticsearch/bulk'
require 'elasticsearch/type'
require 'elasticsearch/command'
require 'elasticsearch/command/read'
require 'elasticsearch/command/setup'
require 'elasticsearch/indices'
