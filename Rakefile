# frozen_string_literal: true

# Rakefile
require_relative 'db/book_reading_tracker_gem.rake'

namespace :db do
  desc 'Tạo database'
  task :create do
    BookReadingTrackerGem::DatabaseTasks.create
  end

  desc 'Xóa database'
  task :drop do
    BookReadingTrackerGem::DatabaseTasks.drop
  end

  desc 'Chạy migrations'
  task :migrate do
    BookReadingTrackerGem::DatabaseTasks.migrate
  end

  desc 'Reset database'
  task :reset do
    BookReadingTrackerGem::DatabaseTasks.reset
  end

  desc 'Seed database'
  task :seed do
    BookReadingTrackerGem::DatabaseTasks.seed
  end
end
