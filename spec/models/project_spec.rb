require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "#tracking_status" do
    it "should have the correct enum keys" do
      expected_keys = %w(
        draft
        pending
        in_progress
        awaiting_information
        awaiting_approval
        approved
        overdue
        cancelled
        completed
      )
      expect(Project.tracking_statuses.keys).to eq(expected_keys)
    end

    context "with an invalid '#tracking_status'" do
      specify { expect(subject).to_not be_valid }

      it "raises ArgumentError with a message 'not a valid tracking_status'" do
        expected_message = "'invalid_enum_tracking_status_value' is not a valid tracking_status"
        expect { Project.new(title: "Project Test 1", tracking_status: :invalid_enum_tracking_status_value) }.to raise_error(ArgumentError, expected_message)
      end
    end

    context "with a valid '#tracking_status'" do
      subject { described_class.new(title: "Project with valid title & Status", tracking_status: :pending) }
      it { is_expected.to be_valid }
    end
  end
end
