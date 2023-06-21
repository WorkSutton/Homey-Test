class AddTrackingStatusToProjects < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE tracking_status AS ENUM ('draft', 'pending', 'in_progress', 'awaiting_information', 'awaiting_approval', 'approved', 'overdue', 'cancelled', 'completed');
    SQL
    add_column :projects, :tracking_status, :tracking_status
  end

  def down
    remove_column :projects, :tracking_status
    execute <<-SQL
      DROP TYPE tracking_status;
    SQL
  end
end
