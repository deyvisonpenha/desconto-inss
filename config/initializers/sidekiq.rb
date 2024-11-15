require 'sidekiq'

redis_config = {
  url: ENV['REDIS_URL'] || 'redis://localhost:6379/0',
  network_timeout: 5,
  pool_timeout: 5,
  reconnect_attempts: 3
}

Rails.application.config.after_initialize do
  Sidekiq.configure_server do |config|
    config.redis = redis_config
    
    # Using error_handlers instead of on_error_handler
    config.error_handlers << proc do |ex, context|
      Rails.logger.error "Sidekiq error: #{ex.message} | Context: #{context}"
    end
  end
  
  Sidekiq.configure_client do |config|
    config.redis = redis_config
  end
end