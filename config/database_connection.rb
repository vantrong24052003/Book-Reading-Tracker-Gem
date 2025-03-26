# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'

class DatabaseConnection
  def self.connect
    database_url = ENV.fetch('DATABASE_URL', nil)
    ActiveRecord::Base.establish_connection(database_url)
    ActiveRecord::Base.logger = Logger.new($stdout)
    puts '✅ Kết nối thành công tới PostgreSQL Database!'
  rescue StandardError
    puts "⚠️ Lỗi kết nối tới database: \#{e.message}"
  end
end
