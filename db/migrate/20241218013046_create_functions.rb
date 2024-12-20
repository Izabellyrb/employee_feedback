# frozen_string_literal: true

class CreateFunctions < ActiveRecord::Migration[8.0]
  def change
    create_table :functions do |t|
      t.string :name
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end
  end
end
