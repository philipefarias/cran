require "lib/local_package"

RSpec.describe LocalPackage do
  subject { described_class.new "Dummy", "0.0.1", source: fixtures_path }
  let(:fixtures_path) { File.expand_path "spec/fixtures" }

  describe "#description" do
    let(:expected) do
      {
        package: "Dummy",
        type: "Package",
        title: "Dummy Package",
        version: "0.0.1",
        date: "2015-07-04",
        author: "Philipe Farias",
        maintainer: "Philipe Farias <philipefairas@gmail.com>",
        description: "Package to be used in tests",
        license: "GPL-3",
        needs_compilation: "no",
        packaged: "2015-07-04 08:00:18 UTC; philipefarias",
        repository: "CRAN",
        publication: "2015-07-04 08:30:07"
      }
    end

    it "returns the parsed package description" do
      expect(subject.description).to eq expected
    end
  end
end
