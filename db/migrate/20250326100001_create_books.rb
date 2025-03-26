# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.string :isbn
      t.integer :published_year
      t.timestamps
    end
      add_index :books, :title
  end
end
