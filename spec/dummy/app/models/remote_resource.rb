class RemoteResource
  attr_accessor :email, :password, :id, :authentication_token

  def initialize(email, password)
    @email = email
    @password = password
    @id = 1
    @authentication_token = '7412394714'
  end

end