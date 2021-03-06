require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret ENV.fetch("DRAGONFLY_SECRET")

  url_format "/media/:job/:sha/:name"

  if Rails.env.development? && ENV['DEV_S3_DRAGONFLY']
    datastore :s3, bucket_name: ENV.fetch('S3_BUCKET_NAME'),
                   access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
                   secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
                   url_scheme: ENV.fetch('S3_SCHEME'),
                   region: ENV.fetch('S3_REGION'),
                   root_path: "#{ENV.fetch('PROJECT_NAME')}/#{Rails.env}/image",
                   fog_storage_options: { path_style: true }
  elsif Rails.env.development? || Rails.env.test?
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  else
    datastore :s3,
      bucket_name: ENV.fetch("S3_BUCKET_NAME"),
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
      url_scheme: ENV.fetch("S3_SCHEME"),
      region: ENV.fetch("S3_REGION"),
      root_path: "#{Rails.env}/image",
      fog_storage_options: {path_style: true}
  end

end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
