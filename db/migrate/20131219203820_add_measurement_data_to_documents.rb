class AddMeasurementDataToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :measurement_data, :boolean, default: false
  end
end
