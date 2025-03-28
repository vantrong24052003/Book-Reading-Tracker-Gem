# frozen_string_literal: true

require 'active_record'
class Author < ActiveRecord::Base
  has_many :book_authors
  has_many :books, through: :book_authors
end
