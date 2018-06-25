module Elastic
  class Query
    def initialize
      @client = Elasticsearch::Client.new log: true
    end

    def self.by_name(term)
      new.query(term)
    end

    def query(term)
      result = @client.search index: 'accounts', body: { query: { match: { name: term } } }
      result['hits']['hits'].map { |h| h['_source']['name'] }
    end
  end
end
