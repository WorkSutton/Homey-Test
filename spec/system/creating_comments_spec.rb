require "rails_helper"

RSpec.feature "Users can add comments to projects", type: :system do
  let(:project) { FactoryBot.create(:project) }

  scenario "with valid attributes" do
    visit project_path(project)

    expect(page).to have_title "Homey - Projects - 11a Lochabar Road"
    expect(page).to have_select "Tracking Status", selected: "Draft"

    click_link "Add Comment"

    # prefer to use the name ("comment[detail]") or id (comment_detail)
    # as the name displayed in the UI may change. The id/name will change less frequently
    fill_in :comment_detail, with: "Update from solicitors"

    click_button "Create Comment"

    expect(page).to have_content "Comment has been created."
    expect(page).to have_content "Update from solicitors"
  end

  scenario "with invalid attributes" do
    visit project_path(project)

    expect(page).to have_title "Homey - Projects - 11a Lochabar Road"
    expect(page).to_not have_select "Tracking Status", selected: "Completed"

    click_link "Add Comment"
    click_button "Create Comment"

    expect(page).to have_content "Comment has not been created."
    expect(page).to_not have_content "Update from solicitors"
    expect(page).to have_content "Please review the problems below:"
    expect(page).to have_content "Detail can't be blank"
  end
end
