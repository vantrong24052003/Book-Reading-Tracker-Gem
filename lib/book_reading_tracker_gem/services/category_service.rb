# frozen_string_literal: true

require_relative '../models/category'
require_relative '../../../config/database_connection'

module BookReadingTrackerGem
  class CategoryService
    def self.ensure_connection
      DatabaseConnection.connect unless ActiveRecord::Base.connected?
    end

    def self.add_category(name)
      ensure_connection
      Category.create!(category_name: name)
      puts "Đã thêm danh mục: #{name}."
    end

    def self.list_categories
      ensure_connection
      categories = Category.all
      categories.each do |category|
        puts "Id: #{category.id}, Danh mục: #{category.category_name}"
      end
    end
  end
end
