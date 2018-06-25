module Elastic
  class Indexing
    def index
      client = Elasticsearch::Client.new log: true

      account = Account.first

      client.index index: 'accounts', type: '_doc', id: 1,
                   body: { name: account.name,
                           email: account.email,
                           address: account.address,
                           balance: account.balance
                   }
    end
  end
end
