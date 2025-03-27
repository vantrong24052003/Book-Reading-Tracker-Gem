# frozen_string_literal: true
require 'active_record'
class BookAuthor < ActiveRecord::Base
  belongs_to :book
  belongs_to :author
end
