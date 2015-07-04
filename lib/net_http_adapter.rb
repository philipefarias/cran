require "net/http"

class NetHttpAdapter
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get(path)
    Net::HTTP.get URI("#{url}/#{path}")
  end
end
