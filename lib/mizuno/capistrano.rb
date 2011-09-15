# Capistrano task for Mizuno.
#
# Just add "require 'mizuno/capistrano'" in your Capistrano deploy.rb
Capistrano::Configuration.instance(:must_exist).load do

  namespace :mizuno do
    desc "Start mizuno"
    task :start, :roles => :app, :except => { :no_release => true } do
      # makes use of capistrano/ext/multistage
      run "cd #{current_path} && RACK_ENV=#{fetch(:stage, 'staging')} bundle exec rake mizuno:start"
    end

    desc "Stop mizuno"
    task :stop, :roles => :app, :except => { :no_release => true }, :on_error => :continue do
      run "cd #{current_path} && bundle exec rake izuno:stop"
    end

    desc "Restart mizuno"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run "cd #{current_path} && bundle exec rake mizuno:restart"
    end
  end
  
end
