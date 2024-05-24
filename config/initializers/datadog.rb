Datadog.configure do |c|
  service_name = "graphql-ruby-hands-on"
  c.tags = { env: Rails.env, app: service_name }
  c.tracing.instrument :rails, service_name: "#{service_name}-rails"
  c.tracing.instrument :sidekiq, service_name: "#{service_name}-sidekiq"
  c.tracing.sampling.default_rate = 1.0 # default is 1.0
  c.tracing.enabled = true
end
