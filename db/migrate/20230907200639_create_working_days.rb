class CreateWorkingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :working_days do |t|
      t.string :day
      t.integer :start_at
      t.integer :ends_at
      t.timestamps
      t.references :doctor, foreign_key: true
    end
  end
end
