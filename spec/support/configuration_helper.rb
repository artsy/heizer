module ConfigurationHelper
  class << self
    def reset
      Heizer.configuration = nil
      Heizer.configure {}
    end
  end
end
