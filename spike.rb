require "bundler/setup"
require "rubygems/package"
require "net/http"
require "open-uri"
require "dcf"

SOURCE_URL = "http://cran.r-project.org/src/contrib/"
PACKAGES_URL = SOURCE_URL + "PACKAGES"

###
# Handling the packages list

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


###
# Handling the package

# making a local copy
def local_package(name, version)
  io = package_uri(name, version).open

  Tempfile.new(filename(name, version)).tap do |f|
    io.rewind
    f.write io.read
    f.close
  end
end

def package_uri(name, version)
  URI.parse "#{SOURCE_URL}#{filename(name, version)}"
end

def filename(name, version)
  "#{name}_#{version}.tar.gz"
end

# getting the important info
def extract_description(package, package_name)
  raw = extract_from_tar package.path, package_name, "DESCRIPTION"
  parse_dcf raw
end

def extract_from_tar(path, package_name, filename)
  content = ""
  gzip = Zlib::GzipReader.open(path)

  Gem::Package::TarReader.new gzip do |tar|
    content << tar.seek("#{package_name}/#{filename}", &:read)
  end

  content
end


###
# Utils

def parse_dcf(content)
  Dcf.parse content
end


###
# Doing stuff

packages = fetch_packages_list 3
packages.each do |(name, version)|
  package = local_package(name, version)
  description = extract_description package, name
  puts description
end

