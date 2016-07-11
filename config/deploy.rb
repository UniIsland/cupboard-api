# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'cupboard-api'
set :repo_url, 'https://github.com/UniIsland/cupboard-api.git'
set :branch, 'master'
set :deploy_to, ENV['DEPLOY_DIR']
set :log_level, :info
append :linked_files, '.rbenv-vars'
append :linked_dirs, 'log', 'tmp', 'vendor/bundle'#, '.keys'

set :default_env, { path: '$HOME/.rbenv/shims:/usr/local/bin:/usr/bin:/bin' }
set :ssh_options, { forward_agent: true, auth_methods: %w(publickey), port: 10086 }

set :conditionally_migrate, true

set :nginx_server_name, ENV['SERVERNAME']
set :puma_nginx, :app
