# frozen_string_literal: true

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

    def self.remove_book(id)
      ensure_connection
      book = Book.find_by(id: id)
      if book
        book.reading_progress&.destroy
        book.book_authors.destroy_all
        book.destroy
        puts "Đã xóa sách: #{id}."
      else
        puts "Không tìm thấy sách: #{id}."
      end
    end

    def self.update_status(id, status)
      valid_statuses = %w[unread reading read]
      unless valid_statuses.include?(status)
        puts "Trạng thái không hợp lệ. Chỉ chấp nhận: #{valid_statuses.join(', ')}"
        return
      end

      ensure_connection
      book = Book.find_by(id: id)
      if book.nil?
        puts "Không tìm thấy sách: #{id}"
        return
      end

      if book.reading_progress.nil?
        puts "Sách '#{book.title}' chưa có tiến độ đọc."
        return
      end

      # Cập nhật trạng thái
      book.reading_progress.update!(status: status)
      puts "Đã cập nhật trạng thái sách: #{book.title} thành '#{status}'."
    end

    def self.update_progress(id, pages_read)
      if pages_read.negative?
        puts 'Số trang không thể là số âm.'
        return
      end

      ensure_connection
      book = Book.find_by(id: id)

      if book.nil?
        puts "Không tìm thấy sách: #{id}"
        return
      end

      reading_progress = book.reading_progress
      if reading_progress.nil?
        puts "Sách '#{book.title}' chưa có tiến độ đọc."
        return
      end

      total_pages = reading_progress.total_pages

      if pages_read > total_pages
        puts "Số trang đã đọc: #{pages_read} không thể lớn hơn tổng số trang: #{total_pages}."
        return
      end

      # Cập nhật tiến độ
      reading_progress.update!(pages_read: pages_read)
      puts "Đã cập nhật tiến độ đọc sách: #{book.title} đến trang #{pages_read}."

      # Tự động cập nhật trạng thái dựa trên tiến độ
      if pages_read.zero?
        update_status(id, 'unread')
      elsif pages_read < total_pages
        update_status(id, 'reading')
      elsif pages_read == total_pages
        update_status(id, 'read')
      end
    end

    def self.list_books
      ensure_connection
      books = Book.includes(:reading_progress).all
      books.each do |book|
        puts "Id: #{book.id}, Tiêu đề: #{book.title}, Trạng thái: #{book.reading_progress&.status || 'N/A'}, Trang đã đọc: #{book.reading_progress&.pages_read || 0}/#{book.reading_progress&.total_pages || 0}, ISBN: #{book.isbn}, Năm xuất bản: #{book.published_year}"
      end
    end

    def self.stats
      ensure_connection
      total_books = Book.count
      read_books = ReadingProgress.where(status: 'read').count
      reading_books = ReadingProgress.where(status: 'reading').count
      unread_books = ReadingProgress.where(status: 'unread').count

      puts "Tổng số sách: #{total_books}"
      puts "Sách đã đọc: #{read_books}"
      puts "Sách đang đọc: #{reading_books}"
      puts "Sách chưa đọc: #{unread_books}"
    end

    def self.show_progress(id)
      ensure_connection
      book = Book.find_by(id: id)
      if book.nil?
        puts "Không tìm thấy sách: #{id}"
        return
      end

      if book.reading_progress.nil?
        puts "Sách '#{id}' chưa có tiến độ đọc."
      else
        puts "Tiến độ đọc sách '#{id}': #{book.reading_progress.pages_read}/#{book.reading_progress.total_pages} trang, Trạng thái: #{book.reading_progress.status}"
      end
    end
  end
end
