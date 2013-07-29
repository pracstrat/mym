set :rails_env,       "staging"
set :application,     "mym.pracstrat.com"
server application,   :app, :web, :db, :primary=>true
set :user,            "programmer"
set :port,            30000
set :deploy_to,       "/home/#{user}/public_html/mym.pracstrat.com"
set :rails_env,       "staging"
set :rvm_ruby_string, "2.0.0-p247"
