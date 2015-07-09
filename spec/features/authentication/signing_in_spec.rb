require 'spec_helper'

feature 'Signing in' do
  scenario 'Successful sign in via form' do
    visit '/'
    fill_in 'Email', with: "john.doe@gmail.com"
    fill_in 'Password', with: "1234_password"
    click_button 'Log in'
    expect(page).to have_content('You have reached your destination!')
  end
end

