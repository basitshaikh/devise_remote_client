require 'spec_helper'

describe Devise::SessionsController do
  login_user
  describe 'logout' do
    it 'should redirect to the root path (Devise default)' do
      expect(get :destroy).to redirect_to(root_path)
    end
  end
end
