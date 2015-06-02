# Devise Remote Client

Devise Remote Client provides basical tools to allow your to manage devise users
inside of a client Rails application, with a custom backend server.

This is mostly useful to manage authentication and other aspects of devise's
user management with a web service as the backend, but all the remote
communication is let to your to implement.

This means that there are no assumptions on the way your client app communcates
with your backend, and you'll be able to customize it to your needs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_remote_client'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install devise_remote_client
```

## Usage

You'll certainly be using a PORO, or `ActiveModel::Model` object for defining
your devise model.

For devise to work with your object, you'll need to include the following in
your model :

```ruby
class User
  extend ActiveModel::Callbacks
  extend Devise::Models

  define_model_callbacks :validation
end
```

### Remote authenticable

Allows to authenticate your user remotely with a custom callback.

Add the `:remote_authenticable` module to your devise model :

```ruby
class User
  extend ActiveModel::Callbacks
  extend Devise::Models

  define_model_callbacks :validation

  devise :remote_authenticatable

  attr_accessor :id, :authentication_token
end
```

Now, configure the `authentication_method` callback method in your `devise.rb`
initializer like the following :

```ruby
config.remote_authenticatable.authentication_method do |authentication_hash|
  # authentication_hash contains :email and :password keys to allow your
  # to call your backend and return an object that respond to `#id` and
  # `#authentication_token`
end
```

You should now be able to sign your users in with the usual session routes.

## Contributing

1. Fork it ( https://github.com/glyph-fr/devise_remote_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
