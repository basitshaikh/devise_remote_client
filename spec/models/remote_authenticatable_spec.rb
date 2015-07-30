require 'spec_helper'

describe Devise::Models::RemoteAuthenticatable do
  class User
    # https://github.com/glyph-fr/devise_remote_client/issues/1
    # The errors seems to be due to the fact that your model does not define any
    # argument inside its constructor method, since you have not declared the initialize method.
    # Two solutions
    # 1) define initialize method
    # 2) include ActiveModel::Model instead of ActiveModel::Validations
    include ActiveModel::Model #required because some before_validations are defined in devise
    extend ActiveModel::Callbacks #required to define callbacks
    extend Devise::Models

    define_model_callbacks :validation #required by Devise

    devise :remote_authenticatable

    attr_accessor :id, :authentication_token, :email, :password, :surname, :first_name
  end

  subject(:user) { User.new }

  context 'No remote authentication_method defined' do
    it 'throws a NoMethodError exception when you haven\'t defined the authentication_method' do
      expect {
        user.remote_authentication(nil)
      }.to raise_exception(NoMethodError)
    end
  end

  context 'Defined a remote authentication_method' do

    class RemoteResource
      attr_accessor :email, :password, :id, :authentication_token

      def initialize(email, password)
        @email = email
        @password = password
        @surname = 'Berlusconi'
        @first_name = 'Silvio'
        @midlle_name = 'whatever'
        @id = 1
        @authentication_token = '7412394714'
      end

    end

    Devise.remote_authenticatable.authentication_method do |authentication_hash|
      if authentication_hash[:password] == 'password'
        remote_resource = RemoteResource.new(authentication_hash[:email], authentication_hash[:password])
      elsif authentication_hash[:password] == 'exception'
        raise ArgumentError.new('Remote authentication failed')
      end
    end

    it 'authenticates via the defined authentication_method' do
      user.remote_authentication({ email: 'user@user.com', password: 'password'})
      expect(user.id).to eq(1)
      expect(user.authentication_token).to eq('7412394714')
    end

    it 'user fields id and authentication_token are nil, when the defined authentication_method fails' do
      user.remote_authentication({ email: 'user@user.com', password: 'invalid password'})
      expect(user.id).to be_nil
      expect(user.authentication_token).to be_nil
    end

    it 'raises the exception of the defined authentication_method' do
      expect {
        user.remote_authentication({ email: 'user@user.com', password: 'exception'})
      }.to raise_exception(ArgumentError)
    end

    context 'defined a remote_authentication_model_to_local_model_method' do
      Devise.remote_authenticatable.remote_authentication_model_to_local_model_method do |remote_model, local_model|
        remote_model.instance_variables.each do |instance_variable|
          puts "#{instance_variable}"
          if local_model.respond_to?("#{instance_variable[1..-1]}=")
            local_model.instance_variable_set("#{instance_variable}",
                                              remote_model.instance_variable_get("#{instance_variable}"))
          end
        end
      end

      it 'it executes the defined remote_authentication_model_to_local_model_method when authentication was successful' do
        user.remote_authentication({ email: 'user@user.com', password: 'password'})
        expect(user.id).to eq(1)
        expect(user.authentication_token).to eq('7412394714')
        expect(user.surname).to eq('Berlusconi')
        expect(user.first_name).to eq('Silvio')
      end
    end
  end
end