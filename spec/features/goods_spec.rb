require 'rails_helper'

RSpec.feature "Goods", type: :feature do

  it "Creates a new good" do
    make_user_and_login
		visit '/goods/new'
		within("#new_good") do
			fill_in 'Name', :with => 'My goods'
			fill_in 'Description', :with => 'My goods description'
		end
		click_button 'Create Good'
		expect(page).to have_content 'Good was successfully created'
	end

  it "doesn't create a new good if form isn't filled out" do
    make_user_and_login
    visit '/goods/new'
    within("#new_good") do
      fill_in 'Name', :with => ''
      fill_in 'Description', :with => 'My goods description'
    end
    click_button 'Create Good'
    expect(page).to have_content 'Name can\'t be blank'
  end

  
end
