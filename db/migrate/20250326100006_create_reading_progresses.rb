# frozen_string_literal: true

class CreateReadingProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :reading_progresses do |t|
      t.references :book, null: false, foreign_key: true
      t.string :status, null: false, default: 'unread'
      t.integer :pages_read, default: 0
      t.integer :total_pages, default: 0
      t.date :started_at
      t.date :finished_at
      t.timestamps
    end
    add_index :reading_progresses, :status
  end
end
