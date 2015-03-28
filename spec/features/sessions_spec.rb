require 'rails_helper'

RSpec.feature "The sign-in process", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before :each do
    User.create(:email => 'user@example.com', :password => 'password', :first_name => 'Micky', :last_name => 'Mouse', :city => 'Los Angeles', :state => 'CA')
  end

  it "signs me in" do
    visit '/sessions/new'
    within("form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log yourself in'
    expect(page).to have_content 'Edit Profile'
  end

  it "doesn't let me sign in" do
    visit '/sessions/new'
    within("form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'passwod'
    end
    click_button 'Log yourself in'
    expect(page).to have_content 'Login Failed. Please Try Again.'
  end

  
end