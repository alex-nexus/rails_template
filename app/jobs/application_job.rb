class ApplicationJob < ActiveJob::Base
  extend JobBase
  include Shoryuken::Worker

  rescue_from ActiveJob::DeserializationError do |ex|
    Shoryuken.logger.error ex
    Shoryuken.logger.error ex.backtrace.join("\n")
  end
end
