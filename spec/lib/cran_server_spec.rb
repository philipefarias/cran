require "active_support/core_ext/string/strip"
require "lib/cran_server"
require "yaml"

RSpec.describe CranServer do
  subject { described_class.new source_url, http_client }

  let(:source_url)  { "http://cran.example.com/src/contrib" }
  let(:http_client) { HttpDummy }

  class HttpDummy
    def initialize(_)
    end

    def get(_)
      <<-PACKAGES.strip_heredoc
        Package: A3
        Version: 0.9.2
        Depends: R (>= 2.15.0), xtable, pbapply
        Suggests: randomForest, e1071
        License: GPL (>= 2)
        NeedsCompilation: no

        Package: abbyyR
        Version: 0.1
        Depends: R (>= 3.2.0)
        Imports: httr, XML
        License: GPL (>= 2)
        NeedsCompilation: no

        Package: abc
        Version: 2.1
        Depends: R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit
        License: GPL (>= 3)
        NeedsCompilation: no
      PACKAGES
    end
  end

  describe "#list" do
    let(:expected) do
      [
        { package: "A3",     version: "0.9.2" },
        { package: "abbyyR", version: "0.1"   },
        { package: "abc",    version: "2.1"   }
      ]
    end

    it "returns a list of packages names and versions" do
      expect(subject.list).to eq expected
    end
  end
end
