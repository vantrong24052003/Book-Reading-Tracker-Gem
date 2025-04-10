# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :author_name, null: false
      t.text :biography
      t.timestamps
    end
    add_index :authors, :author_name
  end
end
