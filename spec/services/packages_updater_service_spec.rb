RSpec.describe PackagesUpdaterService do
  subject { described_class.new DummyServer }
  let(:repo) { subject.repository }

  class DummyServer
    def initialize(_)
    end

    def list(_)
      [
        { package: "Dummy", version: "0.0.1" }
      ]
    end

    def url
      File.expand_path "spec/fixtures"
    end
  end

  it "creates the package" do
    expect(repo.count).to eq 0

    subject.call

    expect(repo.count).to eq 1

    package = repo.first

    expect(package.name).to eq "Dummy"
    expect(package.version).to eq "0.0.1"
    expect(package.authors.first.name).to eq "Philipe Farias"
  end
end
