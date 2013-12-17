# This migration comes from rapidfire (originally 20130502195415)
class CreateRapidfireAttempts < ActiveRecord::Migration
  def change
    create_table :rapidfire_attempts do |t|
      t.references :survey
      t.references :user
      t.date :activity_date
      t.text :description
      t.string :completed_for, array: true, default: []

      t.timestamps
    end
    add_index :rapidfire_attempts, :survey_id
    add_index :rapidfire_attempts, :user_id
  end
end
