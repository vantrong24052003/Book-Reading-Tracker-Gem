# frozen_string_literal: true

class Author < ActiveRecord::Base
  has_many :book_authors
  has_many :books, through: :book_authors
end
