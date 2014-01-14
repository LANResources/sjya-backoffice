class AddActivityTypeToRapidfireAttempts < ActiveRecord::Migration
  def change
    add_column :rapidfire_attempts, :activity_type, :string
  end
end
