require "lograge/sql/extension"
require Rails.root.join("lib/json_log_formatter")

Rails.application.configure do
  logger = ActiveSupport::Logger.new(Rails.root.join("log", "#{Rails.env}.log"))
  logger.formatter = JsonLogFormatter.new

  config.logger = ActiveSupport::TaggedLogging.new(logger)
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new
  config.lograge.keep_original_rails_log = true
  config.colorize_logging = false
  config.lograge_sql.keep_default_active_record_log = true
  config.lograge_sql.min_duration_ms = 5000 # milliseconds Defaults is zero
  config.lograge.custom_options = lambda do |event|
    {
      ddsource: "ruby",
      params: event.payload[:params].reject { |k| %w(controller action).include? k },
      level: event.payload[:level],
    }
  end
end
