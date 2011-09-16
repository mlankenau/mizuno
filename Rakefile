$: << 'lib'

require 'mizuno/rake_tasks'
Mizuno::RakeTasks.new do |m|
  m.pidfile = "mizuno.pid"
  m.outfile = "mizuno.out"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
