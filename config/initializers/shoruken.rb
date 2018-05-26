Shoryuken.configure_server do |config|
  # Replace Rails logger so messages are logged wherever Shoryuken is logging
  # Note: this entire block is only run by the processor, so we don't overwrite
  #       the logger when the app is running as usual.

  Rails.logger = Shoryuken::Logging.logger
  Rails.logger.level = Rails.application.config.log_level

  # config.server_middleware do |chain|
  #  chain.add Shoryuken::MyMiddleware
  # end

  # For dynamically adding queues prefixed by Rails.env
  # %w(queue1 queue2).each do |name|
  #   Shoryuken.add_queue("#{Rails.env}_#{name}", 1)
  # end
end
