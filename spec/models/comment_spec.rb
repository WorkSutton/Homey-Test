require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:project) { FactoryBot.create(:project) }

  context "with invalid attributes" do
    it "cannot be created" do
      comment = FactoryBot.create(:comment, project: project)
      comment.detail = nil
      comment.project = project

      expect { comment.save }.to raise_error(ActiveRecord::NotNullViolation, /PG::NotNullViolation: ERROR:  null value in column "detail" of relation "comments" violates not-null constraint/)
    end
  end
end
