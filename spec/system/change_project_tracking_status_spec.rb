require 'rails_helper'

RSpec.feature "Users can change a projects tracking status" do
  let(:lochabar_road_project) { FactoryBot.create(:project) }

  scenario "when an existing project" do
    visit project_path(lochabar_road_project)

    # save_and_open_page

    title = "Homey - Projects"
    expect(page).to have_title title
    expect(page).to have_content "⚪ Draft"

    select "In Progres", from: "Tracking Status"
    click_button I18n.t("simple_form.buttons.project.tracking_status.submit", btn_action_type: :Update)

    expect(page.current_url).to eq project_url(lochabar_road_project)
    expect(lochabar_road_project.reload.tracking_status).to eq("in_progress")
    expect(page).to have_content "🟢 In Progress"
    expect(page).to have_select "Tracking Status", selected: "🟢 In Progress"
  end
end
