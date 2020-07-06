module Heizer
  class Configuration
    attr_accessor :aws_access_key_id
    attr_accessor :aws_secret_access_key

    def initialize
      @aws_access_key_id = 'replace-me'
      @aws_secret_access_key = 'replace-me'
    end
  end
end
