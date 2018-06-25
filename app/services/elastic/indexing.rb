module Elastic
  class Indexing
    INDEX = 'accounts'
    TYPE = '_doc'

    def initialize
      @client = Elasticsearch::Client.new log: true
    end

    def index
      delete_index

      map

      Account.all.map do |acc|
        @client.index index: INDEX, type: TYPE,
                      body: {
                        name: acc.name,
                        email: acc.email,
                        address: acc.address,
                        balance: acc.balance
                      }
      end
    end

    def delete_index
      @client.indices.delete index: INDEX
    end

    def map
      @client.indices.create index: INDEX, body: {
        mappings: {
          TYPE => {
            properties: {
              name: { type: 'text' },
              email: { type: 'text' },
              address: { type: 'text' },
              balance: { type: 'float' }
            }
          }
        }
      }
    end
  end
end
