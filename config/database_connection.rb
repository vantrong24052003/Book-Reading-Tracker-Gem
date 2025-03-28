# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'

class DatabaseConnection
  def self.connect
    return if ActiveRecord::Base.connected? # Tránh kết nối lại nếu đã kết nối

    # Lấy chế độ cơ sở dữ liệu từ ENV, mặc định là 'local'
    database_mode = ENV.fetch('DATABASE_MODE', 'supabase')

    database_url = case database_mode
                   when 'supabase'
                     ENV.fetch('DATABASE_URL_SUPABASE', 'postgresql://postgres.rfvveqejqtxfszsgdzml:Admin123%40@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres')
                   when 'local'
                     ENV.fetch('DATABASE_URL_LOCAL', 'postgresql://vantrong:Admin123%40@localhost:5432/book_reading_tracker')
                   end

    if database_url.nil?
      puts "Không tìm thấy cấu hình DATABASE_URL cho chế độ #{database_mode}"
      return
    end

    begin
      ActiveRecord::Base.establish_connection(database_url)
      ActiveRecord::Base.logger = Logger.new($stdout)
      puts "Kết nối thành công đến database ở chế độ #{database_mode}!"
    rescue StandardError => e
      puts "Lỗi kết nối tới database: #{e.message}"
    end
  end
end
