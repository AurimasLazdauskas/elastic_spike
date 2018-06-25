module Elastic
  class Indexing
    def initialize
      @client = Elasticsearch::Client.new log: true
    end

    def index
      Account.all.map do |acc|
        @client.index index: 'accounts', type: '_doc',
                      body: {
                        name: acc.name,
                        email: acc.email,
                        address: acc.address,
                        balance: acc.balance
                      }
      end
    end
  end
end
