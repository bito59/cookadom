Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true

  #Paperclip.options[:command_path] = "/opt/ImageMagick/bin/"
  #config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  Paperclip.options[:command_path] = "/usr/local/bin/"
  # Amazon Web Services - S3
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :s3_protocol => 'https',
      :bucket => ENV['S3_BUCKET_NAME'],
      :s3_host_name => ENV['S3_HOST_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

end
