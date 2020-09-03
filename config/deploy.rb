# -*- coding: utf-8 -*-
# lock '3.5.0'

set :application, 'archatlas'
set :repo_url, 'git@github.com:ARUP-CAS/aiscr-aatlas.git'
set :ssh_options, forward_agent: true
set :deploy_to, -> {  "/home/#{fetch(:application)}/#{fetch(:stage)}" }
set :branch, 'master'

set :linked_dirs,  %w{log public/system tmp db/sphinx}
set :linked_files, %w{ .env }

set :sidekiq_role, :worker

set :puma_threads, [0, 8]
set :puma_workers, 0
set :whenever_roles, -> { :cron }

set :rvm_roles, [ :app, :worker ]
set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'

before 'deploy:publishing', 'puma:create_dirs'
after 'deploy:publishing', 'puma:restart'
