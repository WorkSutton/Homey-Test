require "rails_helper"

RSpec.describe TrackingStatusHistory, type: :model do
  def history
    history = TrackingStatusHistory.where(project_id: project.reload.id).order(id: :asc)
    current_history, previous_history = history.partition do |record|
      record.history_ended_at.nil?
    end
    return [history, current_history, previous_history]
  end

  context "with a new project on creation" do
    let(:project) { FactoryBot.build(:project, title: "Project testing Creation") }
    let(:project_history) { history[0] }

    specify do
      expect { project.save }.to change(TrackingStatusHistory, :count).by(1)
    end

    it "defaults the status to 'draft'" do
      project.save

      expect(project.tracking_status).to eq "draft"
      expect(TrackingStatusHistory.last).to have_attributes(
        tracking_status: "draft",
        project_id: project.reload.id
      )
      expect(project_history[0].tracking_status).to eq "draft"
      expect(project_history[0].history_ended_at).to be_nil
      expect(project_history[0].history_started_at).to eq project.updated_at
    end
  end

  context "when updates are made to a project" do
    let(:project) { FactoryBot.build(:project, title: "Project testing Updates") }
    let(:june_22nd_2023_at_101505) { Time.zone.local(2023, 06, 22, 10, 15, 05) }
    let(:june_23th_2023_at_111505) { Time.zone.local(2023, 06, 23, 11, 15, 05) }
    let(:june_24th_2023_at_152040) { Time.zone.local(2023, 06, 24, 15, 20, 40) }

    before do
      travel_to june_22nd_2023_at_101505
      project.save # = FactoryBot.create(:project)
    end

    after do
      travel_back
    end

    context "when tracking_status changes to 'approved' from 'draft'" do
      let(:project_history) { history[0] }
      let(:current_history) { history[1] }
      let(:previous_history) { history[2] }

      before do
        travel_to june_23th_2023_at_111505
        project.approved!
      end

      specify { expect(history[0].size).to eq(2) }
      specify { expect(project_history.size).to eq(2) }

      it "updates 'history_ended_at' for the current record" do
        expect(previous_history.first).to have_attributes(
          tracking_status: "draft",
          project_id: project.id,
          history_started_at: june_22nd_2023_at_101505,
          history_ended_at: june_23th_2023_at_111505
        )
      end

      it "creates a new record" do
        expect(current_history.first).to have_attributes(
          tracking_status: "approved",
          project_id: project.reload.id,
          history_started_at: Time.current,
          history_ended_at: nil
        )
      end
    end

    context "when 'tracking_status' changes from 'approved' to 'in progress'" do
      let(:project_history) { history[0] }
      let(:current_history) { history[1] }
      let(:previous_history) { history[2] }

      before do
        travel_to june_23th_2023_at_111505
        project.approved!

        travel_to june_24th_2023_at_152040
        project.in_progress!
      end

      specify { expect(project_history.size).to eq(3) }

      it "updates 'history_ended_at' for the current record" do
        expect(previous_history.last).to have_attributes(
          tracking_status: "approved",
          project_id: project.reload.id,
          history_started_at: june_23th_2023_at_111505,
          history_ended_at: june_24th_2023_at_152040
        )
      end

      it "doesn't change the 'draft' history record" do
        expect(previous_history.first).to have_attributes(
          tracking_status: "draft",
          project_id: project.reload.id,
          history_started_at: june_22nd_2023_at_101505,
          history_ended_at: june_23th_2023_at_111505
        )
      end

      it "creates a new 'in_progress' record" do
        expect(current_history.first).to have_attributes(
          tracking_status: "in_progress",
          project_id: project.reload.id,
          history_started_at: Time.current,
          history_ended_at: nil
        )
      end

      specify { expect(previous_history.map(&:tracking_status)).to match(%w(draft approved)) }
      specify { expect(previous_history.map(&:tracking_status)).to_not match("in_progress") }
    end
  end
end
