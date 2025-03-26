# frozen_string_literal: true

class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
end
