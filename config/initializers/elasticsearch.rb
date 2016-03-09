Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'] || "http://localhost:9200/"


unless Media.__elasticsearch__.index_exists?
  Media.__elasticsearch__.create_index! force: true
  Media.import
end