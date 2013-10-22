class AddInviteFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_token, :string
    add_column :users, :invited_by, :integer
    add_column :users, :invited_at, :datetime
  end
end
