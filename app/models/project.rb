class Project < ApplicationRecord
  # callbacks
  after_create_commit ->  { record_tracking_status(create_or_update: :update) }
  after_update_commit ->  { record_tracking_status(create_or_update: :update) }

  # associations
  has_many :comments
  has_many :tracking_status_histories, class_name: "TrackingStatusHistory"
  has_many :status_histories, class_name: "StatusHistory"

  # enums
  enum :tracking_status, {
      draft: "draft",
      pending: "pending",
      in_progress: "in_progress",
      awaiting_information: "awaiting_information",
      awaiting_approval: "awaiting_approval",
      approved: "approved",
      overdue: "overdue",
      cancelled: "cancelled",
      completed: "completed"
    }, default: :draft

  # validations
  validates :title, presence: true
  validates :tracking_status, presence: true
  validates :tracking_status, inclusion: {
    in: [
      "draft",
      "pending",
      "in_progress",
      "awaiting_information",
      "awaiting_approval",
      "approved",
      "overdue",
      "cancelled",
      "completed"
    ]
  }

  private

  # we want to detect changes on 'tracking status'
  # - when it changes we want to
  #    - update the existing record
  #    - create a history of what the record was like before the change
  #        - on new projects the attribute will go from 'nil -> draft' (as draft is default)
  #        - on existing projects the attribute will transition between the various values (see enum)
  def record_tracking_status(create_or_update:)
    id_from_nil_to_draft = saved_change_to_tracking_status?(from: nil, to: :draft)
    saved_changes_has_id = saved_changes.key?(:id)
    history_ended_at = history_started_at = updated_at
    # overwrite history_ended_at if it was a new record (create project)
    history_ended_at = nil if saved_changes_has_id && id_from_nil_to_draft
    if !saved_changes_has_id #we have a existing entry to update before creating the new version
      current_historical_record = TrackingStatusHistory.where(project_id: id, history_ended_at: nil).take
      current_historical_record.update_columns(history_ended_at: Time.zone.now, updated_at: Time.zone.now)
    end

    # Now do the create
    history_ended_at = nil if create_or_update == :update
    TrackingStatusHistory.create(
      project: self,
      tracking_status: tracking_status,
      history_started_at: history_started_at,
      history_ended_at: history_ended_at
    )
  end
end
