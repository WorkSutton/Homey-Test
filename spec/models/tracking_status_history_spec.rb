require "rails_helper"

RSpec.describe TrackingStatusHistory, type: :model do
  context "with a new project on creation" do
    let(:new_project) { FactoryBot.build(:project) }

    it "defaults the status to 'draft'" do
      expect(new_project.tracking_status).to eq "draft"
      expect { new_project.save }.to change(TrackingStatusHistory, :count).by(1)
      expect(TrackingStatusHistory.last).to have_attributes(
        tracking_status: "draft",
        project_id: new_project.reload.id
      )

      project_tracking_status = TrackingStatusHistory.find_by(project_id: new_project.reload.id)
      expect(project_tracking_status.tracking_status).to eq "draft"
      expect(project_tracking_status.history_ended_at).to be_nil
      expect(project_tracking_status.history_started_at).to eq new_project.updated_at
    end
  end

  context "when an update is made to the project's tracking_status" do
    let!(:saved_project) { FactoryBot.build(:project) }
    let!(:original_project_creation_time) { Time.zone.local(2023, 06, 22, 12, 44, 00) }
    before do
      travel_to original_project_creation_time
      saved_project.save # = FactoryBot.create(:project)
    end

    after do
      travel_back
    end

    it "records history" do
      june_24th_2023_at_090444 = Time.zone.local(2023, 06, 24, 9, 4, 44)
      travel_to june_24th_2023_at_090444

      expect { saved_project.approved! }.to change(TrackingStatusHistory, :count).by(1)

      history_for_saved_project = TrackingStatusHistory.where(project_id: saved_project.reload.id)
      expect(history_for_saved_project.size).to eq(2)

      # puts "\n\n   ----- Inspection time -----\nNo. records: #{history_for_saved_project.size}\n"
      # history_for_saved_project.each do |p|
      #   puts "#{p.inspect}"
      # end
      # puts "\n   ----- END -----------------\n\n"

      current_history, previous_history = history_for_saved_project.partition do |record|
        record.history_ended_at.nil?
      end
      expect(current_history.first).to have_attributes(
        tracking_status: "approved",
        project_id: saved_project.reload.id,
        history_started_at: Time.current,
        history_ended_at: nil
      )

      june_24th_2023_at_103139 = Time.zone.local(2023, 06, 24, 10, 31, 39)
      travel_to june_24th_2023_at_103139

      saved_project.in_progress!
      history_for_saved_project = TrackingStatusHistory.where(project_id: saved_project.reload.id)
      expect(history_for_saved_project.size).to eq(3)

      current_history, previous_history = history_for_saved_project.partition do |record|
        record.history_ended_at.nil?
      end

      expect(current_history.first).to have_attributes(
        tracking_status: "in_progress",
        project_id: saved_project.reload.id,
        history_started_at: Time.current,
        history_ended_at: nil
      )

      expect(previous_history.first).to have_attributes(
        tracking_status: "draft",
        project_id: saved_project.reload.id,
        history_started_at: original_project_creation_time,
        history_ended_at: june_24th_2023_at_090444
      )

      expect(previous_history.last).to have_attributes(
        tracking_status: "approved",
        project_id: saved_project.reload.id,
        history_started_at: june_24th_2023_at_090444,
        history_ended_at: june_24th_2023_at_103139
      )

      previous_history_tracking_statuses = previous_history.map(&:tracking_status)
      expected_tracking_statuses = %w(draft approved)

      expect(previous_history_tracking_statuses).to match(expected_tracking_statuses)
      expect(previous_history_tracking_statuses).not_to match("in_progress")
    end
  end
end
