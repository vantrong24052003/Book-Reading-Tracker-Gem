# frozen_string_literal: true

require_relative 'book_reading_tracker_gem/version'
require_relative 'book_reading_tracker_gem/clis/cli'
require_relative 'book_reading_tracker_gem/services/book_service'
require_relative 'book_reading_tracker_gem/services/author_service'
require_relative 'book_reading_tracker_gem/services/category_service'
require_relative 'book_reading_tracker_gem/models/book'
require_relative 'book_reading_tracker_gem/models/author'
require_relative 'book_reading_tracker_gem/models/category'
require_relative 'book_reading_tracker_gem/models/book_author'
require_relative 'book_reading_tracker_gem/models/book_category'
require_relative 'book_reading_tracker_gem/models/reading_progress'

module BookReadingTrackerGem
  class Error < StandardError; end
end
