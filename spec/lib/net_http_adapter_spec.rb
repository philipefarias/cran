require "lib/net_http_adapter"

RSpec.describe NetHttpAdapter do
  subject { described_class.new url }
  let(:url) { "http://example.com" }

  describe "#get" do
    it "calls Net::HTTP get with uri" do
      path = "action"
      uri  = URI("#{url}/#{path}")

      expect(Net::HTTP).to receive(:get).with(uri)

      subject.get path
    end
  end
end
