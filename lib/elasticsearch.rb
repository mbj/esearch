require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'abstract_type'

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
require 'elasticsearch/result/aspect'
require 'elasticsearch/result/facet'
require 'elasticsearch/index'
require 'elasticsearch/operation'
require 'elasticsearch/bulk'
require 'elasticsearch/preprocessor'
require 'elasticsearch/preprocessor/response'
require 'elasticsearch/preprocessor/request'
require 'elasticsearch/preprocessor'
require 'elasticsearch/type'
require 'elasticsearch/null_logger'
require 'elasticsearch/middleware'
