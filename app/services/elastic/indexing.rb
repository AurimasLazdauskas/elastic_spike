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
        index_one(acc)
      end
    end

    def index_one(acc)
      @client.index index: INDEX, type: TYPE,
                    id: acc.id,
                    body: {
                        name: acc.name,
                        email: acc.email,
                        address: acc.address,
                        balance: acc.balance
                    }
    end

    def delete_index
      @client.indices.delete index: INDEX if @client.indices.exists? index: INDEX
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
