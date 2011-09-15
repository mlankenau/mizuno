# TODO: set JAVA_OPTS="$JAVA_OPTS -server"

# =============================================================================
# MIZUNO CONFIG
# =============================================================================
MIZUNO_CONFIG = {
  :env     => ENV['RACK_ENV'] || 'development',
  :cmd     => 'bin/mizuno',
  :port    => '30010',
  :pidfile => 'tmp/pids/mizuno.pid',
  :outfile => 'log/mizuno.out'
}

# =============================================================================
# MIZUNO TASKS
# =============================================================================
namespace :mizuno do
  def running?( pidfile )
    return false unless File.exist?( pidfile )

    pid = File.read( pidfile ).to_i
    Process.getpgid( pid ) != -1 ? pid : false
  rescue Errno::ESRCH
    false
  end

  def kill( pid, signal = :TERM )
    print "* killing #{pid} with :#{signal} "
    Process.kill( signal, pid )

    retries = 20
    begin
      retries -= 1
      break if retries.zero?

      print "."
      sleep 0.1
    end while Process.getpgid( pid ) != -1

    # when still running, the forcefully stop
    if Process.getpgid( pid ) != -1
      puts " FAILED"
      kill( pid, :KILL )
    end
  rescue Errno::ESRCH
    print " OK"
  ensure
    puts ""
  end

  desc "Start Mizuno"
  task :start do
    if running?( MIZUNO_CONFIG[:pidfile] )
      warn "* An instance of mizuno is already running"
      Rake::Task[ "mizuno:stop" ].invoke
    end

    puts "Starting mizuno in #{MIZUNO_CONFIG[:env]}"
    command = "#{MIZUNO_CONFIG[:cmd]} -p #{MIZUNO_CONFIG[:port]} -E #{MIZUNO_CONFIG[:env]} -P #{MIZUNO_CONFIG[:pidfile]} >> #{MIZUNO_CONFIG[:outfile]} 2>&1 &"
    sh( command ) { |ok, status| ok or fail "failed with status (#{status.exitstatus})" }
  end

  desc "Stop Mizuno"
  task :stop do
    if pid = running?( MIZUNO_CONFIG[:pidfile] )
      puts "Stopping mizuno (pid: #{pid})"
      kill( pid )
    else
      puts "Mizuno not running"
    end
  end

  desc "Restart Mizuno"
  task :restart => [:stop, :start]

  desc "Status Mizuno"
  task :status do
    if pid = running?( MIZUNO_CONFIG[:pidfile] )
      puts "Mizuno: running (pid: #{pid})"
    else
      puts "Mizuno: not running"
    end
  end
end
