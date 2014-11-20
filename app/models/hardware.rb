class Hardware
  class << self
    def lock
      attempt("lock")
    end

    def unlock
      attempt("unlock")
    end

    def attempt(action)
      core.function(action, "")
      true
    rescue => e
      raise e if Rails.env.development?
      Airbrake.notify(e)
      false
    end

    private

    def core
      RubySpark::Core.new(RubySparkConfig::CORE_ID)
    end
  end
end
