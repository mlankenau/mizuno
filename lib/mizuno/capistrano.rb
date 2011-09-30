# Capistrano task for Mizuno.
#
# Just add "require 'mizuno/capistrano'" in your Capistrano deploy.rb
Capistrano::Configuration.instance(:must_exist).load do

  namespace :mizuno do
    desc "Start mizuno"
    task :start, :roles => :app, :except => { :no_release => true } do
      run_with_pipefail "cd #{current_path} && RACK_ENV=#{fetch(:rack_env, 'staging')} nohup bundle exec rake mizuno:start | tee"
    end

    desc "Stop mizuno"
    task :stop, :roles => :app, :except => { :no_release => true }, :on_error => :continue do
      run_with_pipefail "cd #{current_path} && nohup bundle exec rake mizuno:stop | tee"
    end

    desc "Restart mizuno"
    task :restart, :roles => :app, :except => { :no_release => true } do
      run_with_pipefail "cd #{current_path} && RACK_ENV=#{fetch(:rack_env, 'staging')} nohup bundle exec rake mizuno:restart | tee"
    end

    def run_with_pipefail( cmd )
      run "set -o pipefail; " << cmd
    end
  end
  
end
