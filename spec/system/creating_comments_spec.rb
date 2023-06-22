require "rails_helper"

RSpec.feature "Users can add comments to projects", type: :system do
  let(:project) { FactoryBot.create(:project) }

  scenario "with valid attributes" do
    visit project_path(project)

    expect(page).to have_title "Homey - Projects - 11a Lochabar Road"
    expect(page).to have_content "Tracking Status: Draft"

    click_link "Add Comment"

    # prefer to use the name ("comment[detail]") or id (comment_detail)
    # as the name displayed in the UI may change. The id/name will change less frequently
    fill_in :comment_detail, with: "Update from solicitors"

    click_button "Create Comment"

    expect(page).to have_content "Comment has been created."
    expect(page).to have_content "Update from solicitors"
  end
end
