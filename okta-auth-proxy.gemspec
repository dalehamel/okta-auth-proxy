lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'okta-auth-proxy/version'

Gem::Specification.new do |s|
  s.name        = 'okta-auth-proxy'
  s.version     = OktaAuthProxy::VERSION
  s.date        = '2016-04-09'
  s.summary     = 'Okta for apps without SAML support'
  s.description = 'Auth backend for use with nginx to protect applications with Okta SAML'
  s.authors     = ['Dale Hamel']
  s.email       = 'dale.hamel@srvthe.net'
  s.files       = Dir['lib/**/*']
  s.bindir      = 'bin'
  s.executables << 'okta-auth-proxy'
  s.homepage    = 'https://github.com/dalehamel/okta-auth-proxy'
  s.license = 'MIT'
  s.add_runtime_dependency 'sinatra', ['=1.4.7']
  s.add_runtime_dependency 'omniauth', ['=1.3.1']
  s.add_runtime_dependency 'omniauth-saml', ['=1.5.0']
  s.add_runtime_dependency 'em-synchrony', ['=1.0.4']
  s.add_runtime_dependency 'thin', ['=1.6.4']
  s.add_runtime_dependency 'thor', ['>= 0.19.1']
  s.add_runtime_dependency 'activesupport', ['=4.2.5']
  s.add_development_dependency 'pry', ['=0.10.3']
  s.add_development_dependency 'pry-byebug', ['=3.3.0']
  s.add_development_dependency 'rake', ['=10.4.2']
  s.add_development_dependency 'simplecov', ['=0.10.0']
  s.add_development_dependency 'rspec', ['=3.2.0']
end
