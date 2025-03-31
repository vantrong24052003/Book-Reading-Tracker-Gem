# frozen_string_literal: true

require_relative 'db/book_reading_tracker_gem.rake'

namespace :db do
  # rake db:create
  desc 'Tạo database'
  task :create do
    BookReadingTrackerGem::DatabaseTasks.new.create
  end

  # rake db:drop
  desc 'Xóa database'
  task :drop do
    BookReadingTrackerGem::DatabaseTasks.new.drop
  end

  # rake db:migrate
  desc 'Chạy migrations'
  task :migrate do
    BookReadingTrackerGem::DatabaseTasks.new.migrate
  end

  desc 'Reset database'
  task :reset do
    BookReadingTrackerGem::DatabaseTasks.new.reset
  end

  desc 'Seed database'
  task :seed do
    BookReadingTrackerGem::DatabaseTasks.new.seed
  end
end
