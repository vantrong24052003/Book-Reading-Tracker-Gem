# frozen_string_literal: true
require 'active_record'
class BookCategory < ActiveRecord::Base
  belongs_to :book
  belongs_to :category
end
