class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :user, index: true
      t.string :title
      t.string :item
      t.string :item_size
      t.string :content_type

      t.timestamps
    end
  end
end
