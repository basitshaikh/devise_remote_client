require 'devise'

require 'devise_remote_client/version'

require 'devise_remote_client/models'
require 'devise_remote_client/strategies'
require 'devise_remote_client/devise_config'

module DeviseRemoteClient
end

require 'devise_remote_client/railtie' if defined?(Rails)
