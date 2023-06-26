require 'rails_helper'

RSpec.describe HistoryAggregator, type: :model do
  subject { described_class.new(project) }

  let(:project) { FactoryBot.create(:project) }
  let!(:unassociated_comment) { FactoryBot.create(:comment) }
  let!(:stop_time) { Time.zone.local(2023, 06, 26, 11, 39, 00) }

  before do
    travel_to stop_time
  end

  after do
    travel_back
  end

  describe "#initialize" do
    it "sets 'project' attribute reader" do
      expect(subject.project).to eq project
    end
  end

  describe "#history" do
    context "when no comments (project creation)" do 
      specify { expect(subject.history.size).to eq 1 }
    end

    context "with comments" do
      let!(:first_comment) { FactoryBot.create(:comment, project: project, detail: "First comment", created_at: Time.zone.now + 1.minute) }
      let(:second_comment) { FactoryBot.create(:comment, detail: "Second comment", created_at: Time.zone.now + 6.minutes) }
      let(:third_comment) { FactoryBot.create(:comment, detail: "Third comment", created_at: Time.zone.now + 11.minutes) }

      specify { expect(subject.history.size).to eq 2 }

      # will always have a minimum of 1 tracking status against a project
      # the default is 'Draft'
      it "has only 2 comments and a single tracking_status" do
        project.comments << second_comment

        expect(subject.history.size).to eq 3

        expect(subject.history).to match(
          a_collection_containing_exactly(
            a_hash_including(:created_at, event: "Draft", source: :tracking_status),
            a_hash_including(:created_at, event: "First comment", source: :comment),
            a_hash_including(:created_at, event: "Second comment", source: :comment)
          )
        )
      end
    end

    describe "ordering" do
      let(:first_comment_time) { Time.zone.local(2023, 06, 26, 11, 40, 00) }
      let(:second_comment_time) { Time.zone.local(2023, 06, 26, 11, 45, 00) }
      let(:third_comment_time) { Time.zone.local(2023, 06, 26, 12, 05, 00) }

      let!(:first_comment) { FactoryBot.create(:comment, project: project, detail: "First comment", created_at: Time.zone.now + 1.minute) }
      let(:second_comment) { FactoryBot.create(:comment, detail: "Second comment", created_at: Time.zone.now + 6.minutes) }
      let(:third_comment) { FactoryBot.create(:comment, detail: "Third comment", created_at: Time.zone.now + 5.minutes) }

      let(:in_progress_time) { Time.zone.local(2023, 06, 26, 12, 00, 00) }

      before do
        project.comments << second_comment
        travel_to in_progress_time
        project.in_progress!
        project.comments << third_comment
      end

      after do
        travel_back
      end

      context "when default (parameter nil)" do
        specify { expect(subject.history.size).to eq 5 }

        it "returns an array of hashes ordered least recent to most recent" do
          expected_result = [
            {event: "Draft", created_at: stop_time, source: :tracking_status},
            {event: "First comment", created_at: first_comment_time, source: :comment},
            {event: "Second comment", created_at: second_comment_time, source: :comment},
            {event: "In Progress", created_at: in_progress_time, source: :tracking_status},
            {event: "Third comment", created_at: third_comment_time, source: :comment},
          ]

          expect(subject.history).to eq expected_result
        end
      end

      context "when ascending order 'order: 'asc'" do
        it "returns an array of hashes ordered least recent to most recent" do
          expected_result = [
            {event: "Draft", created_at: stop_time, source: :tracking_status},
            {event: "First comment", created_at: first_comment_time, source: :comment},
            {event: "Second comment", created_at: second_comment_time, source: :comment},
            {event: "In Progress", created_at: in_progress_time, source: :tracking_status},
            {event: "Third comment", created_at: third_comment_time, source: :comment},
          ]

          expect(subject.history(order: 'asc')).to eq expected_result
        end
      end

      context "when descending order 'order: 'desc'" do
        it "returns an array of hashes ordered most recent to least recent" do
          expected_result = [
            {event: "Third comment", created_at: third_comment_time, source: :comment},
            {event: "In Progress", created_at: in_progress_time, source: :tracking_status},
            {event: "Second comment", created_at: second_comment_time, source: :comment},
            {event: "First comment", created_at: first_comment_time, source: :comment},
            {event: "Draft", created_at: stop_time, source: :tracking_status},
          ]

          expect(subject.history(order: :desc)).to eq expected_result
          expect(subject.history(order: 'desc')).to eq expected_result
        end
      end
    end
  end
end
