# frozen_string_literal: true

class ReadingProgress < ActiveRecord::Base
  belongs_to :book
end
