# This migration comes from rapidfire (originally 20130502170733)
class CreateRapidfireSurveys < ActiveRecord::Migration
  def change
    create_table :rapidfire_surveys do |t|
      t.string  :name
      t.boolean :active, default: false
      t.integer :position
      t.timestamps
    end
  end
end
