# https://devcenter.heroku.com/articles/rails-unicorn


worker_processes (ENV["UNICORN_WORKERS"] || 2).to_i
# preload_app true
# timeout 60

