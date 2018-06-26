module Elastic
  class Query
    attr_accessor :names, :avg_balance

    def initialize
      @client = Elasticsearch::Client.new log: true
    end

    def self.by_name(term)
      new.query(term)
    end

    def query(term)
      result = @client.search index: 'accounts', body:
          {
            query: {
              match: {
                name: {
                  query: term,
                  fuzziness: 2,
                  prefix_length: 1
                }
              }
            },
            aggs: {
              avg_balance: {
                avg: {
                  field: :balance
                }
              }
            }
          }
      @avg_balance = result['aggregations']['avg_balance']['value'].to_f
      @names = result['hits']['hits'].map { |h| h['_source']['name'] }
    end
  end
end
