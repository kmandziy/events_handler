# frozen_string_literal: true

class CreateInterviews < ActiveRecord::Migration[7.0]
  def change
    create_table :interviews do |t|
      t.datetime :interview_date
      t.references :application, null: false, index: true

      t.timestamps
    end
  end
end
