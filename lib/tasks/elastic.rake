namespace :elastic do
  task index: :environment do
    Elastic::Indexing.new.index
  end
end
