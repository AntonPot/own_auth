class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.boolean :answer
      t.references :user, index: true, foreign_key: true
      t.references :survey, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
