#!/usr/bin/env ruby
APP_NAME_BASE = 'blue-register'
require 'rubygems'
require 'bundler/setup'
require 'active_support/all'

require 'heroku-headless'
require 'heroku-api'
def pull_request_number
  ENV['TRAVIS_PULL_REQUEST']
end

def pull_request?
  (pull_request_number && pull_request_number != 'false').tap{|result| puts result ? "Yes, pull request!" : "No pull request here..." }
end

def deployable_branch?
  server_for_branch.tap{|result| puts result ? "Yes! Deployable branch!" : "Nope, not a branch we know about" }
end

def deployable?
  pull_request? || deployable_branch?
end

def server_for_branch
  branch = ENV['TRAVIS_BRANCH']
  case branch
  when 'master'
    'production'
  else
    puts "No server configured for #{branch}..."
  end
end

def derive_server_name(base_name)
  if pull_request?
    "#{base_name}-#{pull_request_number}"
  else
    "#{base_name}-#{server_for_branch}"
  end
end

def list_apps(heroku)
  @apps = heroku.get_apps
  @apps.body.select{|a| a['name'].starts_with?(APP_NAME_BASE) }
end

puts "Determining deployability..."
if deployable?
  server_name = derive_server_name(APP_NAME_BASE)
  puts "Deployable!"
  heroku = Heroku::API.new
  begin
    heroku.get_app(server_name)
  rescue Heroku::API::Errors::NotFound
    puts "No app found with name #{server_name}, creating..."
    heroku.post_app('name' => server_name)
  end
  HerokuHeadless.configure do | config |
    config.post_deploy_commands = ['rake db:migrate']
    config.force_push = true
  end
  puts "Deploying to... #{server_name}"
  HerokuHeadless::Deployer.deploy(server_name)
else
  puts "Not deployable for ##{ENV['TRAVIS_PULL_REQUEST']}, branch=#{ENV['TRAVIS_BRANCH']}..."
end

