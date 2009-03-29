# this module holds methods that are specific to this application
# like returning the current version-number etc.
module Projectmanager
  # returns the current version number once and returns it
  # the current version number is saved in config/pm_version
  def self.version
    @@version ||= nil

    unless @@version
      # logging
      logger.info "------------------------"
      logger.info "reading version file"
      logger.info "------------------------"
      @@version =
        File.open("config/pm_version", "r") do |f|
        f.readline
      end
    end

    @@version
  end

  def self.logger
    RAILS_DEFAULT_LOGGER
  end
end
