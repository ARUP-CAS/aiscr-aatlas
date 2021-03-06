# https://devcenter.heroku.com/articles/rails-unicorn


if ENV['RACK_ENV'] == 'production'
  worker_processes 2
  
  app_dir = File.expand_path('../../', __FILE__)
  shared_dir = File.expand_path('../../../shared/', __FILE__)

  preload_app true
  timeout 120

  working_directory app_dir
  user "rails"

  FileUtils.mkdir_p "#{shared_dir}/tmp/sockets"
  listen "#{shared_dir}/tmp/sockets/unicorn.sock", :backlog => 64
  listen 8080, :tcp_nopush => true
  FileUtils.mkdir_p "#{shared_dir}/tmp/pids"
  pid "#{shared_dir}/tmp/pids/unicorn.pid"

  stderr_path "#{app_dir}/log/unicorn.log"
  stdout_path "#{app_dir}/log/unicorn.log"


  before_fork do |_server, _worker|
    Signal.trap "TERM" do
      puts "Unicorn master intercepting TERM, sending myself QUIT instead"
      Process.kill "QUIT", Process.pid
    end

    if defined? ActiveRecord::Base
      ActiveRecord::Base.connection.disconnect!
    end
  end

  after_fork do |_server, _worker|
    Signal.trap "TERM" do
      puts "Unicorn worker intercepting TERM, waiting for master to send QUIT"
    end

    if defined? ActiveRecord::Base
      config = ActiveRecord::Base.configurations[Rails.env] ||
        Rails.application.config.database_configuration[Rails.env]
      config["reaping_frequency"] = (ENV["DB_REAPING_FREQUENCY"] || 10).to_i
      config["pool"] = (ENV["DB_POOL"] || 2).to_i
      ActiveRecord::Base.establish_connection(config)
    end
  end

  before_exec do |server|
    ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
  end
else
  worker_processes 1
  listen 3009
end
