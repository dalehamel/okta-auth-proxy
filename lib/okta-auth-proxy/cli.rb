require 'thor'
require 'okta-auth-proxy'

class OktaAuthProxy::CLI < Thor

  desc 'serve', 'Start the server'
  method_option :threads, type: :numeric, default: 1000, banner: 'THREADS', desc: 'Number of worker threads', aliases: '-t'
  method_option :bind, type: :string, default: '127.0.0.1', banner: 'BIND_HOST', desc: 'Address to bind to', aliases: '-b'
  method_option :port, type: :numeric, default: 3311, banner: 'PORT', desc: 'Port to listen on', aliases: '-p'
  method_option :debug, type: :boolean, default: false, desc: 'Run in debug mode', aliases: '-d'
  def serve(port: nil, threads: nil, bind: nil, debug: nil)
    opts = options.deep_symbolize_keys
    OktaAuthProxy::ProxyServer.new(**opts).run
  end
end
