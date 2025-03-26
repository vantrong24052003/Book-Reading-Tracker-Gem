# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_many :book_categories
  has_many :books, through: :book_categories
end
