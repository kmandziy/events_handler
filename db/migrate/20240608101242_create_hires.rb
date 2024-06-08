class CreateHires < ActiveRecord::Migration[7.0]
  def change
    create_table :hires do |t|
      t.datetime :hire_date
      t.references :application, null: false, index: true

      t.timestamps
    end
  end
end
