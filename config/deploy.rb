# config/deploy.rb
require 'capistrano'
require 'bundler/capistrano'

set :application, "kibana"
set :repository,  "git@github.com:cornet/Kibana.git"

set :scm, :git

# do not use sudo
set :use_sudo, false
set(:run_method) { use_sudo ? :sudo : :run }

set :user, "deploy"
set :group, user
set :runner, user

set :host, "#{user}@33.33.33.11" # We need to be able to SSH to that box as this user.
role :web, host
role :app, host

set :rails_env, :production

# Where will it be located on a server?
set :deploy_to, "/var/www/apps/kibana"

ssh_options[:forward_agent] = true

# Don't touch asset files
set :normalize_asset_timestamps, false

# Unicorn control tasks
namespace :deploy do
  task :restart do
    run "god restart kibana"
  end
  task :start do
    run "god start kibana"
  end
  task :stop do
    run "god stop kibana"
  end
end

