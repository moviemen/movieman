class CheckFsUpdatesJob < ActiveJob::Base
  queue_as :fs_updates

  def perform()
    FsStrategy.new.check_for_updates
  end
end
