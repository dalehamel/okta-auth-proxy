require 'sinatra/base'
require 'omniauth'
require 'omniauth-saml'
require 'securerandom'

module OktaAuthProxy
  module OktaAuth

    COOKIE_DOMAIN = ENV['COOKIE_DOMAIN'] || 'localhost'

    module AuthHelpers
      def protected!
        return if authorized?(request.host)
        redirect to("/auth/saml?redirectUrl=#{URI::encode(request.path)}")
      end

      def authorized?(host)
        if session[:uid]
          return ENV['PROXY_TARGET']
        else
          return false
        end
      end
    end

    def self.registered(app)
      app.helpers OktaAuthProxy::OktaAuth::AuthHelpers

      # Use a wildcard cookie to achieve single sign-on for all subdomains
      app.use Rack::Session::Cookie, secret: ENV['COOKIE_SECRET'] || SecureRandom.random_bytes(24),
                                     domain: COOKIE_DOMAIN
      app.use OmniAuth::Builder do
        provider :saml,
        issuer:                             ENV['SSO_ISSUER'],
        idp_sso_target_url:                 ENV['SSO_TARGET_URL'],
        idp_cert:                           File.read( ENV['CERT_PATH'] || 'okta_cert.pem'),
        name_identifier_format:             "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
        idp_sso_target_url_runtime_params:  {:redirectUrl => :RelayState}
      end
    end
  end
end


#def authenticated?
#  #check_remote_ip = nil
#  #if request.env.has_key? 'HTTP_X_FORWARDED_FOR'
#  #  check_remote_ip = request.env['HTTP_X_FORWARDED_FOR']
#  #else
#  #  check_remote_ip = request.env['HTTP_X_REAL_IP']
#  #end
#  if session[:logged] == true #and session[:remote_ip] == check_remote_ip
#    return true
#  else
#    return false
#  end
#end
#
## Return internal URL or false if unauthorized
#def authorized?(host)
#  authorized = false
#  # Check whether the email address is authorized
#  if ! session.has_key? :email
#    return false
#  end
#  split_email_address = session[:email].split('@')
#  if defined? settings.allowed_email_domains and settings.allowed_email_domains.include? split_email_address.last
#    authorized = true
#  end
#  if authorized == true #and settings.routing.has_key? host
#    return settings.routing[host]
#  else
#    return false
#  end
#end
