# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'

class DatabaseConnection
  def self.connect
    # Lấy chế độ cơ sở dữ liệu từ ENV, mặc định là 'local'
    database_mode = ENV.fetch('DATABASE_MODE', 'local')

    database_url = case database_mode
                   when 'supabase'
                     ENV.fetch('DATABASE_URL_SUPABASE', nil)
                   when 'local'
                     ENV.fetch('DATABASE_URL_LOCAL', nil)
                   end

    if database_url.nil?
      puts "⚠️ Không tìm thấy cấu hình DATABASE_URL cho chế độ #{database_mode}"
      return
    end

    begin
      ActiveRecord::Base.establish_connection(database_url)
      ActiveRecord::Base.logger = Logger.new($stdout)
      puts "Kết nối thành công đến database ở chế độ #{database_mode}!"
    rescue StandardError => e
      puts "⚠️ Lỗi kết nối tới database: #{e.message}"
    end
  end
end
