class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true, index: true
      t.datetime :start_at, index: true
      t.datetime :end_at, null: true
      t.integer :duration, index: true
      t.timestamps
    end
  end
end
