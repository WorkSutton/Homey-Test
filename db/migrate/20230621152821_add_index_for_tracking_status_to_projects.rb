class AddIndexForTrackingStatusToProjects < ActiveRecord::Migration[7.0]
  def change
    add_index :projects, :tracking_status
  end
end
