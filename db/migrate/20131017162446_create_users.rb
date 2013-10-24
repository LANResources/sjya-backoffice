class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :title
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :avatar

      t.timestamps
    end

    add_index :users, :email
  end
end
