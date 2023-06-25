class CreateTrackingStatusHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :tracking_status_histories do |t|
      t.references :project, null: false, foreign_key: true
      t.enum :tracking_status, null: false, enum_type: :tracking_status
      t.timestamp :history_started_at, null: false
      t.timestamp :history_ended_at, null: true

      t.timestamps
    end

    add_index :tracking_status_histories, :tracking_status
  end
end
