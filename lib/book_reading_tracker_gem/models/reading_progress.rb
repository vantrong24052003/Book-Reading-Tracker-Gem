# frozen_string_literal: true
require 'active_record'
class ReadingProgress < ActiveRecord::Base
  belongs_to :book
end
