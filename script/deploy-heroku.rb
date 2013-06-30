#!/usr/bin/env ruby -w
require 'heroku-headless'
pull_request_num = ENV['TRAVIS_PULL_REQUEST']
production = !pull_request_num || pull_request_num == 'false'
server_suffix = production ? 'production' : pull_request_num
HerokuHeadless.configure do | config |
  config.post_deploy_commands = ['rake db:migrate']
end
HerokuHeadless::Deployer.deploy("blue-register-#{suffix}")
