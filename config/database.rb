# frozen_string_literal: true

require 'active_record'
require 'dotenv/load'
require 'logger'

database_url = ENV['DATABASE_URL']
if database_url.nil? || database_url.empty?
  raise "⚠️ Lỗi: DATABASE_URL không được tìm thấy trong .env"
end

ActiveRecord::Base.establish_connection(database_url)
ActiveRecord::Base.logger = Logger.new($stdout)

puts "✅ Kết nối thành công tới PostgreSQL Database!"
