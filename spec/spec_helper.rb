require 'heizer'
require 'byebug'
require 'sequel'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include ConfigurationHelper
  config.include DatabaseHelper
  config.include RemoteFileHelper
end
