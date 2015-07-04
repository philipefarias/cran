require "bundler/setup"
require 'rubygems/package'
require "net/http"
require "open-uri"
require "dcf"

SOURCE_URL = "http://cran.r-project.org/src/contrib/"
PACKAGES_URL = SOURCE_URL + "PACKAGES"

def fetch_packages_list(count = nil)
  parse_packages_list get_packages_list, count
end

def get_packages_list
  uri = URI(PACKAGES_URL)
  Net::HTTP.get uri
end

def parse_packages_list(packages_list, count)
  packages_list = packages_list.split("\n\n").take(count).join("\n\n") if count

  parse_dcf(packages_list).reduce({}) do |list, package|
    name    = package.fetch("Package")
    version = package.fetch("Version")

    list[name] = version
    list
  end
end

def parse_dcf(content)
  Dcf.parse content
end

def package_name(name, version)
  "#{name}_#{version}.tar.gz"
end

def package_uri(name, version)
  URI.parse "#{SOURCE_URL}#{package_name(name, version)}"
end

def local_package(name, version)
  io = package_uri(name, version).open

  Tempfile.new(package_name(name, version)).tap do |f|
    io.rewind
    f.write io.read
    f.close
  end
end

def extract_description(package, package_name)
  raw = extract_from_tar package.path, package_name, "DESCRIPTION"
  parse_dcf raw
end

def extract_from_tar(path, package, filename)
  content = ""
  gzip = Zlib::GzipReader.open(path)

  Gem::Package::TarReader.new gzip do |tar|
    content << tar.seek("#{package}/#{filename}", &:read)
  end

  content
end

packages = fetch_packages_list 3
packages.each do |(name, version)|
  package = local_package(name, version)
  description = extract_description package, name
  puts description
end

