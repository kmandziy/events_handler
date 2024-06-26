# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.integer :status, default: 0
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
