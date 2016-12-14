require 'okta-auth-proxy/app'
require 'thin'
require 'em-synchrony'

module OktaAuthProxy
  class ProxyServer
    def initialize(port: 3311, threads:1000, bind: '127.0.0.1', debug:false)
      debug ||= ENV['DEBUG']

      if debug
        $stdout.sync = true
        $stderr.sync = true
      end

      app = ProxyApp.new
      dispatch = Rack::Builder.app do
        map '/' do
          run app
        end
      end
      @server = Thin::Server.new(port, bind, dispatch, threadpool_size: threads).backend
    end

    def start
      @server.start
    end

    def run
      EM.run do
        init_sighandlers
        @server.start
      end
    end
  private

    def init_sighandlers
      trap(:INT)  { 'Got interrupt'; EM.stop; exit }
      trap(:TERM) { 'Got term';      EM.stop; exit }
    end
  end
end
