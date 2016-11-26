# config valid only for current version of Capistrano
lock '3.5.0'

# basic
set :application, 'cupboard-api'
set :repo_url, 'https://github.com/UniIsland/cupboard-api.git'
set :branch, 'master'
set :deploy_to, ENV['DEPLOY_DIR']
set :log_level, :info
append :linked_files, '.rbenv-vars'
append :linked_dirs, 'log', 'tmp', 'vendor'#, '.keys'

set :default_env, { path: '$HOME/.rbenv/shims:/usr/local/bin:/usr/bin:/bin' }
set :ssh_options, { forward_agent: true, auth_methods: %w(publickey), port: 10086 }

# capistrano/bundler
set :bundle_flags, '--deployment --local' # '--deployment --quiet'

# capistrano/rails/migrations
set :conditionally_migrate, true

# capistrano/puma/nginx
set :nginx_server_name, ENV['SERVERNAME']
set :puma_nginx, :app

namespace :provision do
  desc "download formulas, sync files, and config minion"
  task :config do
    tmp_path = shared_path.join('tmp')
    salt_path = tmp_path.join('salt')
    run_locally do
      execute 'lib/salt/get_formulas.sh'
      roles(:all).each do |host|
        execute :rsync, "-r lib/salt #{host}:#{tmp_path}"
      end
    end
    on roles(:all) do
      within shared_path do
        with salt_path: salt_path do
          execute :bash, salt_path.join('config_minion.sh')
        end
      end
    end
  end

  desc "state.apply"
  task :apply do
    on roles(:all) do
      execute :sudo, 'salt-call --local state.apply'
    end
  end

  desc "provision with salt"
  task :run => %w(provision:config provision:apply)
end
