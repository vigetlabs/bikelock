module RubySparkConfig
  CONFIGURATION_FILE = Rails.root.join('config', "ruby_spark.yml")

  if File.exist?(CONFIGURATION_FILE)
    begin
      ruby_spark_app_config = YAML.load_file(CONFIGURATION_FILE).with_indifferent_access

      ENV["RUBY_SPARK_ACCESS_TOKEN"] = ruby_spark_app_config.fetch(:access_token)
      ENV["RUBY_SPARK_CORE_ID"] = ruby_spark_app_config.fetch(:core_id)

    rescue KeyError
      abort "RubySpark app configuration incomplete. :access_token and :core_id must be provided. For a basic version, run:\n\n    cp config/ruby_spark.yml.example config/ruby_spark.yml"
    end
  end

  begin
    ACCESS_TOKEN = ENV.fetch("RUBY_SPARK_ACCESS_TOKEN")
    CORE_ID      = ENV.fetch("RUBY_SPARK_CORE_ID")
  rescue KeyError
    abort "RubySpark app configuration not found. Set ENV['RUBY_SPARK_ACCESS_TOKEN'] and ENV['RUBY_SPARK_CORE_ID'] or run:\n\n    cp config/ruby_spark.yml.example config/ruby_spark.yml"
  end
end

RubySpark.configuration do |config|
  config.access_token = RubySparkConfig::ACCESS_TOKEN
  config.timeout      = 5.seconds
end
