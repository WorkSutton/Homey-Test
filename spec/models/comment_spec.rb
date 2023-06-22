require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:project) { FactoryBot.create(:project) }
  let(:comment_without_project) { FactoryBot.build(:comment, project: nil) }
  let(:comment) { FactoryBot.build(:comment) }

  context "with invalid attributes" do
    it "cannot be created" do
      comment = FactoryBot.build(:comment, project: project)
      comment.detail = nil
      comment.project = project
      comment.save

      expect(comment).to_not be_valid

      expect(comment.errors.full_messages).to_not be_nil
      expect(comment.errors.size).to eq 1
      expect(comment.errors).to include('detail')
      expect(comment.errors.full_messages).to eq(["Detail can't be blank"])
      expect(comment.errors.full_messages).to match(["Detail can't be blank"])
    end

    it "must have an associated project" do
      expect(comment_without_project).to_not be_valid
      expect(comment_without_project.errors.size).to eq 1
      expect(comment_without_project.errors).to include('project')
      expect(comment_without_project.errors.full_messages).to match(["Project must exist"])
    end
  end

  context "with valid attributes" do
    specify { expect(comment).to be_valid }
  end
end
