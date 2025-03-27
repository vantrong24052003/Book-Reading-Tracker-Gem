require_relative '../models/book'
require_relative '../models/reading_progress'
require_relative '../../../config/database_connection'

module BookReadingTrackerGem
  class BookService
    def self.ensure_connection
      DatabaseConnection.connect unless ActiveRecord::Base.connected?
    end

    def self.add_book(title, author, total_pages, description = nil, isbn = nil, published_year = nil)
      ensure_connection
      book = Book.create!(
        title: title,
        description: description,
        isbn: isbn,
        published_year: published_year
      )
      book.authors.create!(author_name: author)
      book.create_reading_progress!(total_pages: total_pages)
    end

    def self.remove_book(title)
      ensure_connection
      book = Book.find_by(title: title)
      book&.destroy
    end

    def self.update_status(title, status)
      ensure_connection
      book = Book.find_by(title: title)
      book&.reading_progress&.update!(status: status)
    end

    def self.update_progress(title, pages_read)
      ensure_connection
      book = Book.find_by(title: title)
      progress = book&.reading_progress
      progress&.update!(pages_read: pages_read)
    end

    def self.list_books
      ensure_connection
      books = Book.includes(:reading_progress).all
      puts "DEBUG: Số lượng sách: #{books.count}" # Thêm log kiểm tra
      books.each do |book|
        progress = book.reading_progress
        puts "Sách: #{book.title}, Trạng thái: #{progress&.status || 'N/A'}, Trang đã đọc: #{progress&.pages_read || 0}/#{progress&.total_pages || 0}, ISBN: #{book.isbn}, Năm xuất bản: #{book.published_year}"
      end
    end
  end
end
