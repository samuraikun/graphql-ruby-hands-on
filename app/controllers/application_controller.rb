class ApplicationController < ActionController::Base
  def append_info_to_payload(payload)
    super

    case payload[:status]
    when 200..299
      payload[:level] = 'INFO'
    when 300..399
      payload[:level] = 'WARN'
    when 400..499
      payload[:level] = 'ERROR'
    when 500..599
      payload[:level] = 'FATAL'
    else
      payload[:level] = 'UNKNOWN'
    end
  end
end
