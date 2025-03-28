# frozen_string_literal: true

require_relative '../models/author'
require_relative '../../../config/database_connection'
require_relative '../utils/helpers'

module BookReadingTrackerGem
  class AuthorService
    def self.add_author(name, biography = nil)
      DatabaseConnection.connect
      Author.create!(author_name: name, biography: biography)
      puts "Add author: #{name} successfully."
    rescue StandardError => e
      puts "Error adding author: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.list_authors
      DatabaseConnection.connect
      authors = Author.all

      if authors.empty?
        puts 'Authors not found.'
        return
      end

      header = %w[id author_name biography]

      rows = authors.map do |author|
        [
          author.id,
          author.author_name || 'N/A',
          author.biography || 'N/A'
        ]
      end

      CommonUtils.render_table(header, rows)
    rescue StandardError => e
      puts "Error listing authors: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end
  end
end
