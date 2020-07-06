require 'csv'
require 'fog/aws'
require 'active_record'
require 'heizer/version'
require 'heizer/configuration'
require 'heizer/report'
require 'heizer/storage'

module Heizer
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
