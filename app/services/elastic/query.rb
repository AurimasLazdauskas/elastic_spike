module Elastic
  class Query
    def initialize
      @client = Elasticsearch::Client.new log: true
    end


  end
end
