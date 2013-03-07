require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'concord'
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

require 'elasticsearch/request'
require 'elasticsearch/mixin'
require 'elasticsearch/connection'
require 'elasticsearch/cluster'
require 'elasticsearch/type'
require 'elasticsearch/document'
require 'elasticsearch/indices'
require 'elasticsearch/index'
require 'elasticsearch/presenter'
require 'elasticsearch/presenter/search'
require 'elasticsearch/presenter/index'
require 'elasticsearch/presenter/document'
require 'elasticsearch/presenter/status'
require 'elasticsearch/presenter/cluster'
require 'elasticsearch/presenter/hit'
require 'elasticsearch/presenter/hits'
require 'elasticsearch/presenter/aspect'
require 'elasticsearch/presenter/aspect/term'
require 'elasticsearch/presenter/aspect/range'
require 'elasticsearch/presenter/facet'
require 'elasticsearch/command'
require 'elasticsearch/command/search'
require 'elasticsearch/command/status'
require 'elasticsearch/command/index'
require 'elasticsearch/command/document'
require 'elasticsearch/command/cluster'
require 'elasticsearch/command/exist'
