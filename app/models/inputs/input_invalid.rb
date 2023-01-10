# frozen_string_literal: true

# NOTE: ActiveRecord::RecordInvalid と同じように振る舞う
# https://github.com/rails/rails/blob/v7.0.3.1/activerecord/lib/active_record/validations.rb#L15-L29
class Inputs::InputInvalid < StandardError
  attr_reader :record

  def initialize(record = nil)
    if record.present?
      @record = record
      errors = @record.errors.full_messages.join(", ")
      message = I18n.t(:"#{@record.class.i18n_scope}.errors.messages.record_invalid", errors: errors, default: :"errors.messages.record_invalid")
    else
      message = "Record invalid"
    end

    super(message)
  end
end
