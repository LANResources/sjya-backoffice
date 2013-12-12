# This migration comes from rapidfire (originally 20130502195310)
class CreateRapidfireQuestions < ActiveRecord::Migration
  def change
    create_table :rapidfire_questions do |t|
      t.references :survey
      t.string :section
      t.string  :type
      t.string  :question_text
      t.integer :position
      t.text :answer_options
      t.text :validation_rules
      t.integer :follow_up_for_id
      t.text :follow_up_for_condition
      t.boolean :allow_custom, default: false
      t.string :help_text

      t.timestamps
    end
    add_index :rapidfire_questions, :survey_id
  end
end
