require 'rails_helper'

RSpec.feature "The sign-in process", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  before :each do
    @user = User.create(:email => 'user@example.com', :password => 'password', :first_name => 'Micky', :last_name => 'Mouse', :city => 'Los Angeles', :state => 'CA')
  end

  it "signs me in" do
    visit '/sessions/new'
    within("form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'LOG IN'
    expect(page).to have_content 'Edit Profile'
  end

  it "doesn't let me sign in with the wrong password" do
    visit '/sessions/new'
    within("form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'passwod'
    end
    click_button 'LOG IN'
    expect(page).to have_content 'Login Failed. Please Try Again.'
  end

  it "prevents access to user edit page if not logged in" do
    visit edit_user_path(@user)
    expect(page).to have_content 'You must be logged in to complete this action.'
  end

   it 'prevents access to new goods page if not logged in' do
    visit '/goods/new'
    expect(page).to have_content 'You must be logged in to complete this action.'
  end

  it 'prevents access to edit goods if not logged in' do 
    make_user_and_login
    good = make_good
    visit users_path
    click_link 'Log Out'
    visit edit_good_path(good)
    expect(page).to have_content 'You must be logged in to complete this action.'
  end
end