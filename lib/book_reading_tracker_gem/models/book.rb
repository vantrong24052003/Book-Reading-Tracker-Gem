# frozen_string_literal: true

class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors

  has_many :book_categories
  has_many :categories, through: :book_categories

  has_one :reading_progress
end
