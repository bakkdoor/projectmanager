# this module holds methods that are specific to this application
# like returning the current version-number etc.
module Projectmanager
  # returns the current version number once and returns it
  # the current version number is saved in config/pm_version
  def self.version
    @@version ||= nil

    unless @@version
      # logging
      puts "\n------------------------"
      puts "reading version file"
      puts "------------------------"
      @@version =
        File.open("config/pm_version", "r") do |f|
        f.readline
      end
    end

    @@version
  end
end
