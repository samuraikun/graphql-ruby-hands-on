class SampleJob
  include Sidekiq::Job

  # This is a sample Sidekiq job that logs the arguments it receives
  def perform(*args)
    logger.info "SampleJob is being performed with arguments: #{args.inspect}"

    # Simulate some work by sleeping for a few seconds
    sleep 2

    logger.info "SampleJob has completed"
  end
end
