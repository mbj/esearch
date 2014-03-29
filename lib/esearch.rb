# encoding: UTF-8

require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'concord'
require 'abstract_type'
require 'null_logger'
require 'pathname'

# Library namespace
module Esearch
  # Error raised when node signals an exception
  class RemoteError < StandardError; end
  # Error raised when protocol is violated
  class ProtocolError < StandardError; end
end # Esearch

require 'esearch/request'
require 'esearch/mixin'
require 'esearch/connection'
require 'esearch/cluster'
require 'esearch/type'
require 'esearch/document'
require 'esearch/indices'
require 'esearch/index'
require 'esearch/presenter'
require 'esearch/presenter/search'
require 'esearch/presenter/index'
require 'esearch/presenter/document'
require 'esearch/presenter/status'
require 'esearch/presenter/cluster'
require 'esearch/presenter/hit'
require 'esearch/presenter/hits'
require 'esearch/presenter/aspect'
require 'esearch/presenter/aspect/term'
require 'esearch/presenter/aspect/range'
require 'esearch/presenter/facet'
require 'esearch/command'
require 'esearch/command/search'
require 'esearch/command/status'
require 'esearch/command/index'
require 'esearch/command/document'
require 'esearch/command/cluster'
require 'esearch/command/exist'
