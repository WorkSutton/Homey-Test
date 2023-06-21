class RemoveStatusFromProjects < ActiveRecord::Migration[7.0]
    # If this were on a live system and the previous migration was already deployed then a number of
    # options exist. This is a demonstration of what I might do in that scenario. YMMV!

    # 1. Create backup table from existing table
    # 2. Dependant on what backup strategy you have in producton - you DO HAVE ONE RIGHT then take a backup
    # 3. Run the migration
    # 4. In event of having to restore there will need to most likely be some time into testing this strategy
    #    on say a staging environment to make sure it is viable
    # 5. Provide output to the user supporting this migration in the form of 'say' and 'say_with_time' comments
    # 6. Make sure raise ActiveRecord::IrreversibleMigration is raised in the down block

    # 7. consider looking at gems such as:
    #      - strong migrations  - https://github.com/ankane/strong_migrations
    #      - safe-pg-migrations - https://github.com/doctolib/safe-pg-migrations
    #     other options to consider that may give insights are:
    #       - after_party       - https://github.com/theSteveMitchell/after_party
    #       - maintenance_tasks - https://github.com/Shopify/maintenance_tasks

  def change
    # create backup table before performing destructive - column removal
    say " *** WARNING ***"
    say " A backup of the projects table will be (up/migrate) / has been (down/rollback) created as part of this migration"

    reversible do |dir|
      dir.up do
        say_with_time "Creating backup of projects table AS 'backup_projects'" do
          execute %Q[CREATE TABLE backup_projects AS TABLE projects;]
        end
        say "backup_projects successfully created."

        remove_column :projects, :status
        say "status column has been removed", true
        say "it is replaced by tracking_status", true
        say "db/migrate/ '20230620195834_add_tracking_status_to_projects'", true
      end

      dir.down do
        raise ActiveRecord::IrreversibleMigration, "The backup table can be removed at some point in the future"
      end
    end
  end
end

# N.B. Output for the rollback will look something like the following, so you can safely ignore the error.
# --------------------------------------------------------------------------------------------------------
# == 20230620213238 RemoveStatusFromProjects: reverting =========================
# rails aborted!
# StandardError: An error has occurred, this and all later migrations canceled:



# The backup table can be removed at some point in the future

# /usr/src/app/db/migrate/20230620213238_remove_status_from_projects.rb:38:in `block (2 levels) in change'
# /usr/src/app/db/migrate/20230620213238_remove_status_from_projects.rb:37:in `block in change'

# Caused by:
# ActiveRecord::IrreversibleMigration:

# The backup table can be removed at some point in the future

# /usr/src/app/db/migrate/20230620213238_remove_status_from_projects.rb:38:in `block (2 levels) in change'
# /usr/src/app/db/migrate/20230620213238_remove_status_from_projects.rb:37:in `block in change'
# Tasks: TOP => db:rollback
# (See full trace by running task with --trace)

# Task completed in 0m0.893s
# --------------------------------------------------------------------------------------------------------

# Tested with another migration, interesting to note that the timestamp of the migration is not BST, but UTC 