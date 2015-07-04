class PackagesController < ApplicationController
  def index
    @packages = Package.order(name: :desc, created_at: :desc)
  end
end
