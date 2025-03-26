# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'
require 'pg'
require_relative '../config/database_connection'

module BookReadingTrackerGem
  class DatabaseTasks
    class << self
      def connect
        DatabaseConnection.connect
      end

      def migration_context
        migrations_paths = File.expand_path('../db/migrate', __dir__)
        @migration_context ||= ActiveRecord::MigrationContext.new(migrations_paths)
      end

      def create
        connect
        db_name = ENV.fetch('DATABASE_NAME', nil)

        test_connection_url = ENV.fetch('DATABASE_URL_TEST_CONNECT', nil)

        connection = PG.connect(test_connection_url)

        if database_exists?(connection, db_name)
          puts "Lỗi: Database '#{db_name}' đã tồn tại!"
        else
          connection.exec("CREATE DATABASE #{db_name}")
          puts "Đã tạo database: #{db_name} thành công!"
        end

        connection.close
      rescue StandardError => e
        puts "Lỗi khi tạo database: #{e.message}"
      end

      def database_exists?(connection, db_name)
        result = connection.exec("SELECT 1 FROM pg_database WHERE datname = '#{db_name}'")
        result.ntuples.positive?
      end

      def database_exists?(connection, db_name)
        result = connection.exec("SELECT 1 FROM pg_database WHERE datname = '#{db_name}'")
        result.ntuples.positive?
      end

      def drop
        db_name = ENV.fetch('DATABASE_NAME', nil)

        connection = PG.connect(ENV.fetch('DATABASE_URL_TEST_CONNECT', nil))

        connection.exec("SELECT pg_terminate_backend(pg_stat_activity.pid)
                   FROM pg_stat_activity
                   WHERE pg_stat_activity.datname = '#{db_name}'
                   AND pid <> pg_backend_pid();")

        if system("dropdb #{db_name}")
          puts "Đã xóa database: #{db_name}!"
        else
          puts "Lỗi khi xóa database: Database #{db_name} không tồn tại!"
        end

        connection.close
      rescue StandardError => e
        puts "Lỗi khi xóa database: #{e.message}"
      end

      def migrate
        connect
        migration_context.migrate
        puts 'Migrate thành công!'
      rescue StandardError => e
        puts "Lỗi khi migrate: #{e.message}"
      end

      def reset
        drop
        create
        migrate
        seed
        puts 'Reset database thành công!'
      rescue StandardError => e
        puts "Lỗi khi reset database: #{e.message}"
      end

      def seed
        connect
        require_relative '../db/seeds.rb'
        puts 'Đã seed dữ liệu thành công!'
      rescue StandardError => e
        puts "Lỗi khi seed dữ liệu: #{e.message}"
      end
    end
  end
end
