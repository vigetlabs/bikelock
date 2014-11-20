module Twilio
  CONFIGURATION_FILE = Rails.root.join('config', "twilio.yml")

  if File.exist?(CONFIGURATION_FILE)
    begin
      twilio_app_config = YAML.load_file(CONFIGURATION_FILE).with_indifferent_access

      ENV["TWILIO_ACCESS_SID"] = twilio_app_config.fetch(:account_sid)
      ENV["TWILIO_AUTH_TOKEN"] = twilio_app_config.fetch(:auth_token)

    rescue KeyError
      abort "Twilio app configuration incomplete. :account_sid and :auth_token must be provided. For a basic version, run:\n\n    cp config/twilio.yml.example config/twilio.yml"
    end
  end

  begin
    ACCESS_SID = ENV.fetch("TWILIO_ACCESS_SID")
    AUTH_TOKEN = ENV.fetch("TWILIO_AUTH_TOKEN")
  rescue KeyError
    abort "Twilio app configuration not found. Set ENV['TWILIO_ACCESS_SID'] and ENV['TWILIO_AUTH_TOKEN'] or run:\n\n    cp config/twilio.yml.example config/twilio.yml"
  end
end
