require 'rake'
require 'rake/tasklib'

module Mizuno
  class RakeTasks < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    attr_accessor :env
    attr_accessor :cmd, :port
    attr_accessor :pidfile, :outfile
    attr_accessor :java_opts

    def initialize
      @env = ENV['RACK_ENV'] || 'development'
      @cmd, @port = File.dirname(__FILE__) + '/../../bin/mizuno', 3000
      @pidfile, @outfile = 'tmp/pids/mizuno.pid', 'log/mizuno.out'
      @java_opts = nil

      yield self if block_given?

      namespace :mizuno do
        desc "Start Mizuno"
        task(:start) { start }

        desc "Stop Mizuno"
        task(:stop) { stop }

        desc "Restart Mizuno"
        task :restart => [:stop, :start]

        desc "Status Mizuno"
        task(:status) { status }
      end
    end

    def java_opts
      @java_opts.nil? ? '' : "JAVA_OPTS=\"#{@java_opts}\" "
    end
    

    private

    def start
      if running?
        warn "* An instance of mizuno is already running"
        stop
      end

      puts "Starting mizuno in #{env}"
      command = "#{java_opts}#{cmd} -p #{port} -E #{env} -P #{pidfile} >> #{outfile} 2>&1 &"
      sh( command ) { |ok, status| ok or fail "failed with status (#{status.exitstatus})" }
    end

    def stop
      if running?
        puts "Stopping mizuno (pid: #{pid})"
        kill!
      else
        puts "Mizuno not running"
      end
    end

    def status
      if running?
        puts "Mizuno: running (pid: #{pid})"
      else
        puts "Mizuno: not running"
      end
    end

    def running?
      return false unless File.exist?( pidfile )

      Process.getpgid( pid ) != -1
    rescue Errno::ESRCH
      false
    end

    def kill!( signal = :TERM )
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
        kill!( :KILL )
      end
    rescue Errno::ESRCH
      print " OK"
    ensure
      puts ""
    end

    def pid
      File.read( pidfile ).to_i rescue nil
    end

  end
end
