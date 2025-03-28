# frozen_string_literal: true

require_relative '../models/category'
require_relative '../../../config/database_connection'

module BookReadingTrackerGem
  class CategoryService
    def self.add_category(name)
      DatabaseConnection.connect
      Category.create!(category_name: name)
      puts "Add category '#{name}' successfully."
    rescue StandardError => e
      puts "Error adding category: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.list_categories
      DatabaseConnection.connect
      categories = Category.all

      if categories.empty?
        puts 'Categories not found.'
        return
      end

      header = %w[id category_name created_at updated_at]
      rows = categories.map do |category|
        [
          category.id,
          category.category_name || 'N/A',
          category.created_at,
          category.updated_at
        ]
      end

      CommonUtils.render_table(header, rows)
    rescue StandardError => e
      puts "Error listing categories: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end
  end
end
