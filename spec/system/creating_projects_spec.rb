require 'rails_helper'

RSpec.feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"

    click_link "New Project"

    fill_in "Title", with: "Rogers - 100 Lochabar Road, SW3 1QQ"
    fill_in "Description", with: "Lorum imspum text"

    click_button "Create Project"

    expect(page).to have_content "Project has been created."
    expect(page).to have_content "Rogers - 100 Lochabar Road, SW3 1QQ"
  end
end
