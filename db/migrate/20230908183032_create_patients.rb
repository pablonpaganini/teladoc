class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name,
      t.timestamps
      t.references :appointment, foreign_key: true
    end
  end
end
