# frozen_string_literal: true

require_relative '../../config/database'

class CreateTables < ActiveRecord::Migration[8.0]
  def change
    # Bảng Books
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.string :isbn
      t.integer :published_year
      t.timestamps
    end

    # Bảng Authors
    create_table :authors do |t|
      t.string :author_name, null: false
      t.text :biography
      t.timestamps
    end

    # Bảng BookAuthors (N-N)
    create_table :book_authors do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true
      t.index %i[book_id author_id], unique: true
    end

    # Bảng Categories
    create_table :categories do |t|
      t.string :category_name, null: false
      t.timestamps
    end

    # Bảng BookCategories (N-N)
    create_table :book_categories do |t|
      t.references :book, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.index %i[book_id category_id], unique: true
    end

    # Bảng ReadingProgress
    create_table :reading_progresses do |t|
      t.references :book, null: false, foreign_key: true
      t.string :status, null: false, default: 'unread'
      t.integer :pages_read, default: 0
      t.integer :total_pages, default: 0
      t.date :started_at
      t.date :finished_at
      t.timestamps
    end
  end
end
