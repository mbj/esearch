require 'multi_json'
require 'faraday'
require 'adamantium'
require 'equalizer'
require 'descendants_tracker'
require 'abstract_class'

# Library namespace
module Elasticsearch
  class RemoteError < StandardError; end
  class ProtocolError < StandardError; end
end

require 'elasticsearch/connection'
require 'elasticsearch/result'
require 'elasticsearch/result/hit'
require 'elasticsearch/result/facet'
require 'elasticsearch/result/facet/aspect'
require 'elasticsearch/result/facet/terms'
require 'elasticsearch/result/facet/range'
require 'elasticsearch/index'
require 'elasticsearch/operation'
require 'elasticsearch/bulk'
require 'elasticsearch/preprocessor'
require 'elasticsearch/preprocessor/response'
require 'elasticsearch/preprocessor/request'
require 'elasticsearch/preprocessor'
require 'elasticsearch/type'
require 'elasticsearch/hit'
require 'elasticsearch/null_logger'
require 'elasticsearch/middleware'
