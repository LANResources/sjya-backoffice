class CreateSources < ActiveRecord::Migration
  def up
    create_table :sources do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end

    Source.create! [
      { name: 'Heartland Health', short_name: 'HH' },
      { name: 'Juvenile Office', short_name: 'JO' },
      { name: 'Missouri Student Survey', short_name: 'MSS' },
      { name: 'St. Joseph Police Department', short_name: 'SJPD' },
      { name: 'Youth Alliance', short_name: 'YA' }
    ]
  end

  def down
    drop_table :sources
  end
end
