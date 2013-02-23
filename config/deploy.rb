require "bundler/capistrano"

set :default_environment, {'PATH' => "'/home/evermind/packages/bin:/home/evermind/.gems/bin:/usr/lib/ruby/gems/1.8/bin/:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games
:/usr/lib/ruby/gems/1.8/bin//bundle:/home/evermind/usr/local/bin'"}
set :shell, '/bin/bash'

set :domain, "solarfrog.com"
set :application, "resumes.fbceproduction.org"
set :deploy_to, "/home/evermind/resumes.fbceproduction.org"
default_run_options[:pty] = true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git
set :repository, "git@github.com:solarfrog/resumes.git"
set :deploy_via, :remote_cache
set :scm_user, "solarfrog"
set :ssh_options, { :forward_agent => true }
set :user, "evermind"  # The server's user for deploys
set :scm_passphrase, "G0atcheese3"  # The deploy user's password
set :use_sudo, false

server "resumes.fbceproduction.org", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end