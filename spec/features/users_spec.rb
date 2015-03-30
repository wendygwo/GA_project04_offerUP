require 'rails_helper'

RSpec.feature "Users", type: :feature do

  it "creates a new user" do
    visit '/users/new'
    within("form") do
      fill_in 'user[email]', :with => 'user@example.com'
      fill_in 'user[first_name]', :with => 'Kona'
      fill_in 'user[last_name]', :with => 'Gwo'
      fill_in 'user[zip_code]', :with => '90249'
      fill_in 'user[city]', :with => 'Gardena'
      fill_in 'user[state]', :with => 'CA'
      fill_in 'user[password]', :with => 'password'
      fill_in 'user[password_confirmation]', :with => 'password'
    end
    click_button 'CREATE ACCOUNT'
    expect(page).to have_content 'Edit Profile'
  end

  it "doesn't create a new user with invalid email" do
    visit '/users/new'
    within("form") do
      fill_in 'user[email]', :with => 'user@example'
      fill_in 'user[first_name]', :with => 'Kona'
      fill_in 'user[last_name]', :with => 'Gwo'
      fill_in 'user[zip_code]', :with => '90249'
      fill_in 'user[city]', :with => 'Gardena'
      fill_in 'user[state]', :with => 'CA'
      fill_in 'user[password]', :with => 'password'
      fill_in 'user[password_confirmation]', :with => 'password'
    end
    click_button 'CREATE ACCOUNT'
    expect(page).to have_content 'Email is invalid'
  end

  it "doesn't create a new user with mismatched passwords" do
    visit '/users/new'
    within("form") do
      fill_in 'user[email]', :with => 'user@example.com'
      fill_in 'user[first_name]', :with => 'Kona'
      fill_in 'user[last_name]', :with => 'Gwo'
      fill_in 'user[zip_code]', :with => '90249'
      fill_in 'user[city]', :with => 'Gardena'
      fill_in 'user[state]', :with => 'CA'
      fill_in 'user[password]', :with => 'password'
      fill_in 'user[password_confirmation]', :with => 'passworld'
    end
    click_button 'CREATE ACCOUNT'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end
end
