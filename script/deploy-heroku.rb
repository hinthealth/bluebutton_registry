#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'active_support/all'

require 'heroku-headless'
require 'heroku-api'
require 'github_api'

module ContinuousDelivery
  class HerokuServers
    FEATURE_ADDONS = %w/mongohq:sandbox loggly:mole/
    attr_accessor :server_name, :options
    def initialize(server_name, options = {})
      @server_name = server_name
      @options = options
    end

    def heroku
      @heroku ||= Heroku::API.new
    end

    # Implementation/Heroku specific
    def find_server
      begin
        self.heroku.get_app(self.server_name)
      rescue Heroku::API::Errors::NotFound
        puts "No app found with name #{self.server_name}."
        return false
      end
    end

    def create_feature_server
      puts "Creating new server #{self.server_name}"
      self.heroku.post_app('name' => self.server_name)
      FEATURE_ADDONS.each do |addon|
        puts "Adding add-on #{addon}..."
        self.heroku.post_addon(self.server_name, addon)
      end
      # $heroku.put_config_vars(server_name, KEY => 'value')
      puts "Done!"
    end

    def destroy_server(server_name)
      self.heroku.delete_app(server_name)
    end

    def deploy_self
      HerokuHeadless.configure do | config |
        config.post_deploy_commands = ['rake db:migrate']
        config.force_push = true
      end
      puts "Deploying to... #{server_name}"
      HerokuHeadless::Deployer.deploy(server_name)
    end

    def all_servers
      self.heroku.get_apps.body
    end


    # Generic methods

    def find_or_create_feature_server
      find_server || create_feature_server
    end

    def servers_to_clean
      all_servers.select do |server|
        options[:clean].include?(server[:name])
      end
    end

    def clean_up
      servers_to_clean.each do |server_name|
        destroy_server(server_name)
      end
    end

    def deploy!
      find_or_create_feature_server if options[:feature]
      clean_up if options[:clean]
      deploy_self
    end
  end
end

def server_name(suffix)
  base_name = 'blue-register'
  [base_name, suffix.to_s].compact.join('-')
end

if ENV['TRAVIS_BRANCH'] == 'master'
  # The most recent 30 closed pull requests (30 is the default api limit)
  inactive_servers = Github::PullRequests.new.all(*ENV['TRAVIS_REPO_SLUG'].split('/') << {state: 'closed'}).collect{|p| server_name(p.number) }
  deployer = ContinuousDelivery::HerokuServers.new(server_name('production'), clean: inactive_servers)
elsif ENV['TRAVIS_PULL_REQUEST'] && ENV['TRAVIS_PULL_REQUEST'] != 'false'
  deployer = ContinuousDelivery::HerokuServers.new(server_name(ENV['TRAVIS_PULL_REQUEST']), feature: true)
end
if deployer
  deployer.deploy!
else
  puts "Nothing to deploy."
end
