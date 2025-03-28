# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'

class DatabaseConnection
  def self.connect
    # Kiểm tra xem đã connect chưa để tránh connect lại
    return if ActiveRecord::Base.connected?

    database_mode = ENV.fetch('DATABASE_MODE', 'supabase')

    database_url = case database_mode
                   when 'supabase'
                     ENV.fetch('DATABASE_URL_SUPABASE',
                               'postgresql://postgres.rfvveqejqtxfszsgdzml:Admin123%40@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres')
                   when 'local'
                     ENV.fetch('DATABASE_URL_LOCAL',
                               'postgresql://vantrong:Admin123%40@localhost:5432/book_reading_tracker')
                   end

    if database_url.nil?
      puts "DATABASE_URL not found for mode #{database_mode}"
      return
    end

    begin
      ActiveRecord::Base.establish_connection(database_url)
      # ActiveRecord::Base.logger = Logger.new($stdout)
      puts "Successfully connected to the database in #{database_mode} mode!"
    rescue StandardError => e
      puts "Failed to connect to the database: #{e.message}"
    end
  end

  def self.disconnect
    return unless ActiveRecord::Base.connected?

    begin
      ActiveRecord::Base.connection_pool.with_connection do |conn|
        # Clear prepared statements ( để tranh lỗi khi chạy câu lệnh này mà tiếp tục chạy lệnh khác)
        conn.execute('DISCARD ALL;')
      end
      ActiveRecord::Base.connection_pool.disconnect!
      puts 'Successfully disconnected from the database!'
    rescue StandardError => e
      puts "Error while disconnecting: #{e.message}"
    end
  end
end
