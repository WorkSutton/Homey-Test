require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "#status" do
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
      expect(Project.statuses.keys).to eq(expected_keys)
    end

    context "with an invalid '#status'" do
      specify { expect(subject).to_not be_valid }

      it "adds an ErrorMessage with an :attribute of 'status' and message hash value of 'can\'t be blank'" do
        expected_message = "Status can't be blank"
        expected_hash = { status: ["can't be blank"] }
        person = described_class.new(title: "Project Test 1")
        person.valid?

        expect(person.errors.size).to eq 1
        expect(person.errors[:status]).to_not be_nil
        expect(person.errors.map(&:attribute)).to include(:status)
        expect(person.errors.messages).to include(expected_hash)
        expect(person.errors[:status]).to include("can't be blank")
        expect(person.errors.full_messages).to include(expected_message)
      end

      it "raises ArgumentError with a message 'not a valid status'" do
        expected_message = "'invalid_status_value' is not a valid status"
        expect { Project.new(title: "Project Test 1", status: :invalid_status_value) }.to raise_error(ArgumentError, expected_message)
      end
    end

    context "with a valid '#status'" do
      subject { described_class.new(title: "Project with valid title & Status", status: :pending) }
      it { is_expected.to be_valid }
    end
  end
end
