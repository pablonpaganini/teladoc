class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :start_at
      t.integer :ends_at
      t.string  :date
      t.timestamps
      t.references :doctor, foreign_key: true
      t.references :patient, foreign_key: true
    end
  end
end
