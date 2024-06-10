# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :type
      t.references :initiable, polymorphic: true

      t.timestamps
    end
  end
end
