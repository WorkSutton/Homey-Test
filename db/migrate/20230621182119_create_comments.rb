class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :detail, null: false
      t.references :project, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
