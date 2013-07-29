require 'capistrano/ext/multistage'
require 'capistrano_colors'
require 'rvm/capistrano'
require 'bundler/capistrano'
require 'airbrake/capistrano'

set :stages, %w(staging production)
set :default_stage, 'staging'

set :repository, 'git@github.com:pracstrat/mym.git'
set :scm, :git
set :scm_verbose, true
set :checkout, 'export'
set :deploy_via, :remote_cache
set :use_sudo, false
set :bundle_flags, '--deployment --quiet --binstubs=.bin'
set :bundle_without, [:test, :development, :capybara]
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Bonus! Colors are pretty!
def red(str)
  "\e[31m#{str}\e[0m"
end

# Figure out the name of the current local branch
def current_git_branch
  branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  puts "Deploying branch #{red branch}"
  branch
end

# Set the deploy branch to the current branch
set :branch, current_git_branch

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
