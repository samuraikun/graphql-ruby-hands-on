class JsonLogFormatter < Logger::Formatter
  def call(severity, time, progname, message)
    log = {
      timestamp: time.iso8601(6),
      level:     severity,
      progname:,
      message:,
    }

    # TODO: .to_json performance is slow, consider using a faster JSON serializer e.g. Oj
    "#{log.to_json}\n"
  end
end
