ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# change default binding ip for `rails s`
# https://stackoverflow.com/questions/28668436/how-to-change-the-default-binding-ip-of-rails-4-2-development-server
require 'rails/commands/server'
module Rails
  class Server
    def default_options
      super.merge(Host: '0.0.0.0', Port: 3000)
    end
  end
end
