class CreateSectors < ActiveRecord::Migration
  def up
    create_table :sectors do |t|
      t.string :name

      t.timestamps
    end

    add_index :sectors, :name

    Sector.create! [
      { name: 'Business Community' },
      { name: 'Schools' },
      { name: 'Government' },
      { name: 'Health Care Professionals' },
      { name: 'Law Enforcement Agency' },
      { name: 'Media' },
      { name: 'Parents/Caregivers' },
      { name: 'Religious/Fraternal' },
      { name: 'Civic/Volunteer Group' },
      { name: 'Youth' },
      { name: 'Youth Serving Organizations' },
      { name: 'Other Organization with Expertise in Substance Abuse' },
      { name: 'General Community' }
    ]
  end

  def down
    drop_table :sectors
  end
end
