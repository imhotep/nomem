#require 'capistrano/ext/multistage'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "nomem"
set :user, "nomem"
set :scm_user, "nomem"
set :scm_passphrase, "YaVdHy2L"
set :use_sudo, false
set :keep_releases, 5

set :scm, :git
set :branch, 'master'
set :repository,  "git@github.com:imhotep/#{application}.git"
set :deploy_to, "/var/www/nomem"

set :deploy_via, :remote_cache

set :env, "production"
set(:app_server){ "97.107.130.23" }

role :app, app_server
role :web, app_server
role :db,  app_server, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
