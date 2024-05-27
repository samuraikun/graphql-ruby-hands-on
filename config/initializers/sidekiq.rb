redis_config = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

class CustomLoggingMiddleware
  include Sidekiq::ServerMiddleware

  def call(job, payload, _queue)
    log_data = { job_name: job.class.name, status: 'START', jid: job.jid, args: payload['args'], start_time: Time.zone.now }
    Sidekiq.logger.info(log_data)
    yield
    log_data.merge!(status: 'END', end_time: Time.zone.now)
    Sidekiq.logger.info(log_data)
  rescue StandardError => e
    log_data.merge!(status: 'ERROR', failed_time: Time.zone.now, error_message: e.message, stack_trace: e.backtrace.join("\n"))
    Sidekiq.logger.error(log_data)
    raise e
  end
end

Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 5
  config.redis = redis_config
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new
  config.server_middleware do |chain|
    chain.add CustomLoggingMiddleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
