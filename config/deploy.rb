# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'cupboard'
set :repo_url, 'https://github.com/UniIsland/cupboard-api.git'
set :branch, 'master'
set :deploy_to, ENV['DEPLOY_DIR']
set :linked_files, fetch(:linked_files, []).push('.rbenv-vars')
set :linked_dirs, fetch(:linked_dirs, []).push(
  # '.keys',
  'log',
  'tmp',
)
set :log_level, :info

set :conditionally_migrate, true

set :default_env, { path: '$HOME/.rbenv/shims:/usr/local/bin:/usr/bin:/bin' }
set :ssh_options, { forward_agent: true, auth_methods: %w(publickey), port: 10086 }

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :doctor do
  desc "inspect remote env"
  task :env do
    on roles(:all) do |host|
      puts capture(:env)
    end
  end

  # desc "inspect remode default encoding"
  # task :encoding do
  #   on roles(:all) do
  #     within release_path do
  #       puts capture(:rails, "runner 'puts Encoding.default_external'")
  #     end
  #   end
  # end

  # desc "inspect config value"
  # task :config do
  #   puts fetch(:linked_dirs)
  # end
end
