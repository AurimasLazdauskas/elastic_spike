module Elastic
  class Query
    attr_accessor :names, :avg_balance

    def initialize
      @client = Elasticsearch::Client.new log: true
    end

    def self.by_name(term)
      new.query(term)
    end

    def query(field, term)
      result = @client.search index: 'accounts', body:
          {
            query: {
              match: {
                field => {
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

    def by_balance(from, to, sort)
      result = @client.search index: 'accounts', body:
          {
            size: 10000,
            sort: {
              balance: sort
            },
            query: {

                    range: {
                      balance: {
                        lte: to,
                        gte: from
                      }.delete_if{ |k,v| v.blank? }
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
      @names = result['hits']['hits'].map { |h| h['_id'] }
    end
  end
end
