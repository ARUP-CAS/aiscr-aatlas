if Rails.env.production?

  require 'raven'

  Raven.configure do |config|
    config.dsn = ENV.fetch("RAVEN_DSN")
  end

end
