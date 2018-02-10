#!/usr/bin/env puma

directory '/home/huangtao/deploy/cupboard-api/current'
rackup "/home/huangtao/deploy/cupboard-api/current/config.ru"
environment 'production'

pidfile "/home/huangtao/deploy/cupboard-api/shared/tmp/pids/puma.pid"
state_path "/home/huangtao/deploy/cupboard-api/shared/tmp/pids/puma.state"
stdout_redirect '/home/huangtao/deploy/cupboard-api/shared/log/puma_access.log', '/home/huangtao/deploy/cupboard-api/shared/log/puma_error.log', true


threads 0,16

bind 'unix:///home/huangtao/deploy/cupboard-api/shared/tmp/sockets/puma.sock'

workers 0



prune_bundler


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/huangtao/deploy/cupboard-api/current/Gemfile"
end


