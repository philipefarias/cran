require "lib/local_package"

RSpec.describe LocalPackage do
  subject { described_class.new "Dummy", "0.0.1", source: fixtures_path }
  let(:fixtures_path) { File.expand_path "spec/fixtures" }

  describe "#description" do
    let(:expected) do
      {
        "Author" => "Philipe Farias",
        "Date" => "2015-07-04",
        "Date/Publication" => "2015-07-04 08:30:07",
        "Description" => "Package to be used in tests",
        "License" => "GPL-3",
        "Maintainer" => "Philipe Farias <philipefairas@gmail.com>",
        "NeedsCompilation" => "no",
        "Package" => "Dummy",
        "Packaged" => "2015-07-04 08:00:18 UTC; philipefarias",
        "Repository" => "CRAN",
        "Title" => "Dummy Package",
        "Type" => "Package",
        "Version" => "0.0.1"
      }
    end

    it "returns the parsed package description" do
      expect(subject.description).to eq expected
    end
  end
end
