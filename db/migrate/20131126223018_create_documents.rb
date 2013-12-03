class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user, index: true
      t.string :title
      t.string :item

      t.timestamps
    end
  end
end
