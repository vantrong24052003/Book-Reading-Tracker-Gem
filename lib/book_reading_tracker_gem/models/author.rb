# frozen_string_literal: true

require 'active_record'
class Author < ActiveRecord::Base
  has_many :book_authors67
  has_many :books, through: :book_authors
end
