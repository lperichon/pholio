set :application, "quintophoto"
set :domain, "74.63.8.222"
set :user, "variete"

set :repository,  "#{user}@#{domain}:/home/#{user}/git/#{application}"
set :scm, :git

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :scm_username, user
set :runner, user
set :use_sudo, false
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :deploy_to, "/home/variete/apps/quintophoto"
set :rails_env, :production

set :chmod755, ["app","config","db","lib","public","vendor","script","script/*","public/disp*"]

default_run_options[:pty] = true

namespace :deploy do
  task :start do

  end

  task :stop do
    
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Set the proper permissions for directories and files on HostingRails accounts"
  task :after_deploy do
    run(chmod755.collect do |item|
      "chmod 755 #{current_path}/#{item}"
    end.join(" && "))
  end
end