ENV["ELASTICSEARCH_URL"] = "http://localhost:9200,http://localhost:9201"

Searchkick.client_options = {
  retry_on_failure: true
}
