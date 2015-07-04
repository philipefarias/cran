require "dcf"

class CranServer
  attr_reader :url

  PACKAGES_FILE = "PACKAGES"

  def initialize(source_url, http_client = NetHttpAdapter, dcf_parser = Dcf)
    @url    = source_url
    @client = http_client.new url
    @parser = dcf_parser
  end

  def list(count = nil)
    fetch_packages_list count
  end

  private

  attr_reader :client, :parser

  def fetch_packages_list(count)
    packages_list = get_packages_list
    packages_list = packages_list.split("\n\n").take(count).join("\n\n") if count
    parsed = parse packages_list

    parsed.map! do |package|
      package.inject({}) do |trans, (k,v)|
        trans[k.downcase.to_sym] = v.to_s if k.match(/Package|Version/)
        trans
      end
    end
  end

  def get_packages_list
    client.get PACKAGES_FILE
  end

  def parse(content)
    parser.parse(content)
  end
end
