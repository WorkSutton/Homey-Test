require 'rails_helper'

RSpec.feature "Users can create new projects" do
  scenario "with valid attributes" do
    visit "/"

    click_link "New Project"

    fill_in "Title", with: "Rogers @ 100 Lochabar Road, London, SW3 1QQ"
    fill_in "Description", with: "Lorum imspum text"

    click_button "Create Project"

    expect(page).to have_content "Project has been created."
    expect(page).to have_content "Rogers @ 100 Lochabar Road, London, SW3 1QQ"

    project = Project.find_by(title: "Rogers @ 100 Lochabar Road, London, SW3 1QQ")
    expect(page.current_url).to eq project_url(project)

    title = "Homey - Projects - Rogers @ 100 Lochabar Road, London, SW3 1QQ"
    expect(page).to have_title title
  end
end
