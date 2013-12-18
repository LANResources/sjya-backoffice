class AddSectorToOrganizations < ActiveRecord::Migration
  def change
    add_reference :organizations, :sector, index: true
  end
end
