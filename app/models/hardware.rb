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
      handle_error(e)
      false
    end

    private

    def core
      RubySpark::Core.new(RubySparkConfig::CORE_ID)
    end

    def handle_error(e)
      raise e if Rails.env.development?
      Airbrake.notify(e)
    end
  end
end
