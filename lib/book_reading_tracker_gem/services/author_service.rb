# frozen_string_literal: true

require_relative '../models/author'
require_relative '../../../config/database_connection'

module BookReadingTrackerGem
  class AuthorService
    def self.ensure_connection
      DatabaseConnection.connect unless ActiveRecord::Base.connected?
    end

    def self.add_author(name, biography = nil)
      ensure_connection
      Author.create!(author_name: name, biography: biography)
      puts "Đã thêm tác giả: #{name}."
    end

    def self.list_authors
      ensure_connection
      authors = Author.all
      authors.each do |author|
        puts "Id: #{author.id},Tác giả: #{author.author_name}, Tiểu sử: #{author.biography || 'Không có'}"
      end
    end
  end
end
