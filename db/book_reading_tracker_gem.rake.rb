# db/book_reading_tracker_gem.rb
require 'active_record'
require 'dotenv/load'
require 'logger'
require_relative '../config/database'

module BookReadingTrackerGem
  module DatabaseTasks
    class << self
      def migration_context
        @migration_context ||= ActiveRecord::MigrationContext.new(
          File.expand_path('../migrate', __dir__),
          ActiveRecord::SchemaMigration
        )
      end

      # Tạo database
      def create
        db_config = ActiveRecord::Base.connection_db_config
        system("createdb #{db_config.database}")
        puts "✅ Đã tạo database: #{db_config.database}!"
      rescue StandardError => e
        puts "⚠️ Lỗi khi tạo database: #{e.message}"
      end

      # Xóa database
      def drop
        db_name = ActiveRecord::Base.connection.current_database
        system("dropdb #{db_name}")
        puts "🗑️ Đã xóa database: #{db_name}!"
      rescue StandardError => e
        puts "⚠️ Lỗi khi xóa database: #{e.message}"
      end

      # Chạy migrations
      def migrate
        migration_context.migrate
        puts "✅ Migrate thành công!"
      end

      # Rollback migration gần nhất
      def rollback(steps = 1)
        migration_context.rollback(steps)
        puts "↩️ Rollback #{steps} bước thành công!"
      end

      # Reset toàn bộ database
      def reset
        drop
        create
        migrate
        seed
        puts "♻️ Reset database thành công!"
      end

      # Seed dữ liệu mẫu
      def seed
        require_relative '../../db/seeds'
        puts "🌱 Đã seed dữ liệu thành công!"
      end
    end
  end
end
