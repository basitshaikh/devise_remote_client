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
  # , :rememberable, :registerable

  attr_accessor :id, :authentication_token, :email, :password
end
