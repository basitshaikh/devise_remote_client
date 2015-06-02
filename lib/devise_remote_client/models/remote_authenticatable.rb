module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern

      mattr_accessor :_authentication_method
      @@_authentication_method = nil

      def self.authentication_method(&block)
        self._authentication_method = block
      end

      def remote_authentication(authentication_hash)
        unless _authentication_method
          raise NoMethodError,
            'You must configure the authentication_method callback in your ' \
            'devise.rb initializer with : ' \
            'config.remote_authenticable.authentication_method'
        end

        # Your logic to authenticate with the external webservice
        data = _authentication_method.call(authentication_hash)

        self.id = data.id
        self.authentication_token = data.authentication_token
      end

      private

      module ClassMethods
        # This method is called from:
        # Warden::SessionSerializer in devise
        #
        # It takes as many params as elements had the array
        # returned in serialize_into_session
        #
        # Recreates a resource from session data
        #
        def serialize_from_session(id, authentication_token)
          resource = self.new
          resource.id = id
          resource.authentication_token = authentication_token
          resource
        end

        #
        # Here you have to return and array with the data of your resource
        # that you want to serialize into the session
        #
        # You might want to include some authentication data
        #
        def serialize_into_session(resource)
          [resource.id, resource.authentication_token]
        end
      end
    end
  end
end

Devise.add_module :remote_authenticatable, controller: :sessions,
                                           model: 'devise_remote_client/models/remote_authenticable',
                                           route: { session: :routes }
