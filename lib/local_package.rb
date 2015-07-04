require "rubygems/package"
require "open-uri"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/string/inflections"

class LocalPackage
  def initialize(name, version, source: nil, parser: Dcf)
    @name    = name
    @version = version
    @source  = source
    @parser  = parser
    @io      = open uri_for(name, version)
  end

  def description
    package = tempfile(name, version)
    extract_description package, name
  end

  private

  attr_reader :name, :version, :source, :parser, :io

  def tempfile(name, version)
    Tempfile.new(filename(name, version), tmp_folder, encoding: encoding).tap do |f|
      io.rewind
      f.write io.read
      f.close
    end
  end

  def encoding
    io.rewind
    io.read.encoding
  end

  def tmp_folder
    Rails.root.join("tmp")
  end

  def uri_for(name, version)
    "#{source}/#{filename(name, version)}"
  end

  def filename(name, version)
    "#{name}_#{version}.tar.gz"
  end

  def extract_description(package, package_name)
    raw = extract_from_tar_gz package.path, package_name, "DESCRIPTION"
    parse(raw)
  end

  def extract_from_tar_gz(path, package_name, filename)
    content = ""
    gzip = Zlib::GzipReader.open(path)

    Gem::Package::TarReader.new gzip do |tar|
      content << tar.seek("#{package_name}/#{filename}", &:read)
    end

    content
  end

  def parse(content)
    parser.parse(content).first
  end
end
