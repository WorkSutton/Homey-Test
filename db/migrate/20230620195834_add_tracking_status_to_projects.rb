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

# N.B. Discovered this after writing the migration. Rails 7 now supports creating Postgres enums natively
# in migrations

# Instead of the SQL Heredoc one can simply use 'create_enum'

# - https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/PostgreSQLAdapter.html#method-i-create_enum
# - https://api.rubyonrails.org/v7.0/classes/ActiveRecord/Enum.html
# - https://stackoverflow.com/a/72509670

# Have not tested that it works with above format with new method!
# Need to add index!
