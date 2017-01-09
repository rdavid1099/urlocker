class HotReadsService
  def self.record_read(link)
    Read.create(link: link)
    conn.post '/api/v1/reader', {url: link.url, title: link.title}
  end

  private
    def self.conn
      url = (ENV['RAILS_ENV'] == 'test' ? 'http://127.0.0.1:2000' : 'https://hot-reader.herokuapp.com')
      Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end
end
