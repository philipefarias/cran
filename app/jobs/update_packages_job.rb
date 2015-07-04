class UpdatePackagesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    PackagesUpdaterService.new(CranServer, 50).call
  end
end
