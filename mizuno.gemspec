Gem::Specification.new do |spec|
    spec.name = "mizuno"
    spec.version = "0.4.2"
    spec.required_rubygems_version = Gem::Requirement.new(">= 1.2") \
        if spec.respond_to?(:required_rubygems_version=)
    spec.authors = [ "Don Werve" ]
    spec.description = 'Jetty-powered running shoes for JRuby/Rack.'
    spec.summary = 'Rack handler for Jetty 7 on JRuby.  Features multithreading, event-driven I/O, and async support.'
    spec.email = 'don@madwombat.com'
    spec.executables = [ "mizuno" ]
    spec.files = %w( .gitignore
        README.markdown
        LICENSE
        mizuno.gemspec
        lib/java/jetty-ajp-8.0.4.v20111024.jar
        lib/java/jetty-all-8.0.4.v20111024-javadoc.jar
        lib/java/jetty-annotations-8.0.4.v20111024.jar
        lib/java/jetty-client-8.0.4.v20111024.jar
        lib/java/jetty-continuation-8.0.4.v20111024.jar
        lib/java/jetty-deploy-8.0.4.v20111024.jar
        lib/java/jetty-http-8.0.4.v20111024.jar
        lib/java/jetty-io-8.0.4.v20111024.jar
        lib/java/jetty-jmx-8.0.4.v20111024.jar
        lib/java/jetty-jndi-8.0.4.v20111024.jar
        lib/java/jetty-overlay-deployer-8.0.4.v20111024.jar
        lib/java/jetty-plus-8.0.4.v20111024.jar
        lib/java/jetty-policy-8.0.4.v20111024.jar
        lib/java/jetty-rewrite-8.0.4.v20111024.jar
        lib/java/jetty-security-8.0.4.v20111024.jar
        lib/java/jetty-server-8.0.4.v20111024.jar
        lib/java/jetty-servlet-8.0.4.v20111024.jar
        lib/java/jetty-servlets-8.0.4.v20111024.jar
        lib/java/jetty-util-8.0.4.v20111024.jar
        lib/java/jetty-webapp-8.0.4.v20111024.jar
        lib/java/jetty-websocket-8.0.4.v20111024.jar
        lib/java/jetty-xml-8.0.4.v20111024.jar
        lib/java/servlet-api-3.0.jar
        lib/mizuno/http_server.rb
        lib/mizuno/rack_servlet.rb
        lib/mizuno.rb
        bin/mizuno )
    spec.homepage = 'http://github.com/matadon/mizuno'
    spec.has_rdoc = false
    spec.require_paths = [ "lib" ]
    spec.rubygems_version = '1.3.6'
    spec.add_dependency('rack', '>= 1.0.0')
end
