require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'descendants_tracker'

# Library namespace
module Elasticsearch
  class RemoteError < StandardError; end
  class ProtocolError < StandardError; end
end

require 'elasticsearch/connection'
require 'elasticsearch/result'
require 'elasticsearch/index'
require 'elasticsearch/preprocessor'
require 'elasticsearch/preprocessor/response'
require 'elasticsearch/preprocessor/request'
require 'elasticsearch/preprocessor'
require 'elasticsearch/type'
require 'elasticsearch/hit'
require 'elasticsearch/hit_set'
require 'elasticsearch/facet'
require 'elasticsearch/facet_set'
require 'elasticsearch/facet/type'
require 'elasticsearch/null_logger'
require 'elasticsearch/middleware'
