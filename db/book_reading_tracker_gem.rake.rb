# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'
require_relative '../config/database_connection'

module BookReadingTrackerGem
  class DatabaseTasks
    class << self
      def connect
        DatabaseConnection.connect
      end

      def migration_context
        path = '../db/migrate/' 
        migrations_paths = File.expand_path(path, __dir__)
  puts '-------------------------------------'
        puts migrations_paths
        @migration_context ||= ActiveRecord::MigrationContext.new(migrations_paths)
      end

      def create
        connect # 🏷️ Gọi connect trước khi chạy create
        db_name = ENV.fetch('DATABASE_NAME', nil)
        existing_databases = ActiveRecord::Base.connection.execute('SELECT datname FROM pg_database WHERE datistemplate = false;')
        database_names = existing_databases.values.flatten

        if database_names.include?(db_name)
          puts "⚠️ Lỗi: Database '#{db_name}' đã tồn tại!"
        else
          ActiveRecord::Base.connection.create_database(db_name)
          puts "✅ Đã tạo database: #{db_name} thành công!"
        end
      rescue StandardError => e
        puts "⚠️ Lỗi khi tạo database: #{e.message}"
      end

      def drop
        connect
        db_name = ActiveRecord::Base.connection.current_database
        if system("dropdb #{db_name}")
          puts "🗑️ Đã xóa database: #{db_name}!"
        else
          puts "⚠️ Lỗi khi xóa database: Không thể xóa #{db_name}!"
        end
      rescue StandardError => e
        puts "⚠️ Lỗi khi xóa database: #{e.message}"
      end

      def migrate
        connect
        migration_context.migrate
        puts '✅ Migrate thành công!'
      rescue StandardError => e
        puts "⚠️ Lỗi khi migrate: #{e.message}"
      end

      def rollback(steps = 1)
        connect
        migration_context.rollback(steps)
        puts "↩️ Rollback #{steps} bước thành công!"
      rescue StandardError => e
        puts "⚠️ Lỗi khi rollback: #{e.message}"
      end

      def reset
        drop
        create
        migrate
        seed
        puts '♻️ Reset database thành công!'
      rescue StandardError => e
        puts "⚠️ Lỗi khi reset database: #{e.message}"
      end

      def seed
        connect
        require_relative '../../db/seeds'
        puts '🌱 Đã seed dữ liệu thành công!'
      rescue StandardError => e
        puts "⚠️ Lỗi khi seed dữ liệu: #{e.message}"
      end
    end
  end
end
