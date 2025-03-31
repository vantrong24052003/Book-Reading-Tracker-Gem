# frozen_string_literal: true

require_relative '../models/book'
require_relative '../models/reading_progress'
require_relative '../../../config/database_connection'
require_relative '../utils/helpers'
module BookReadingTrackerGem
  class BookService
    def self.add_book(title, author_ids, total_pages, description = nil, isbn = nil, published_year = nil)
      DatabaseConnection.connect

      # Xóa id trùng của tác giả 
      unique_author_ids = author_ids.uniq

      book = Book.create!(
        title: title,
        description: description,
        isbn: isbn,
        published_year: published_year
      )

      unique_author_ids.each do |author_id|
        author = Author.find(author_id)
        book.authors << author unless book.authors.include?(author)
      end

      book.create_reading_progress!(total_pages: total_pages)

      puts "Add book: #{book.title} successfully with #{unique_author_ids.size} author(s)."
    rescue StandardError => e
      puts "Error adding book: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.remove_book(id)
      DatabaseConnection.connect
      book = Book.find_by(id: id)
      if book
        book.reading_progress&.destroy
        book.book_authors.destroy_all
        book.destroy
        puts "Removed book: #{id}."
      else
        puts "Book not found: #{id}."
      end
    rescue StandardError => e
      puts "Error removing book: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.update_status(id, status)
      valid_statuses = %w[unread reading read]
      unless valid_statuses.include?(status)
        puts "Invalid status. Accepted: #{valid_statuses.join(', ')}"
        return
      end

      DatabaseConnection.connect
      book = Book.find_by(id: id)
      if book.nil?
        puts "Book not found: #{id}"
        return
      end

      if book.reading_progress.nil?
        puts "No reading progress for '#{book.title}'."
        return
      end

      book.reading_progress.update!(status: status)
      puts "Updated status of '#{book.title}' to '#{status}'."
    rescue StandardError => e
      puts "Error updating status: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.update_progress(id, pages_read)
      if pages_read.negative?
        puts 'Pages read cannot be negative.'
        return
      end

      DatabaseConnection.connect
      book = Book.find_by(id: id)

      if book.nil?
        puts "Book not found: #{id}"
        return
      end

      reading_progress = book.reading_progress
      if reading_progress.nil?
        puts "No reading progress for '#{book.title}'."
        return
      end

      total_pages = reading_progress.total_pages

      if pages_read > total_pages
        puts "Pages read: #{pages_read} cannot exceed total pages: #{total_pages}."
        return
      end

      reading_progress.update!(pages_read: pages_read)
      puts "Updated reading progress for '#{book.title}' to page #{pages_read}."

      if pages_read.zero?
        update_status(id, 'unread')
      elsif pages_read < total_pages
        update_status(id, 'reading')
      elsif pages_read == total_pages
        update_status(id, 'read')
      end
    rescue StandardError => e
      puts "Error updating progress: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.list_books
      DatabaseConnection.connect
      books = Book.includes(:authors).all

      if books.empty?
        puts 'No books in the system.'
        return
      end

      header = %w[id title description isbn published_year authors created_at updated_at]

      rows = books.map do |book|
        # Giới hạn lại thông tin để tránh bảng rộng bị -> dọc
        author_names = (book.authors.map(&:author_name).join(', ').then { |a| a.empty? ? 'N/A' : "#{a[0..20]}..." })

        # Giới hạn mô tả để tránh bảng quá rộng
        description = "#{(book.description || 'N/A')[0..30]}..."
        title = "#{(book.title || 'N/A')[0..20]}..."

        [
          book.id,
          title,
          description,
          book.isbn || 'N/A',
          book.published_year || 'N/A',
          author_names,
          book.created_at,
          book.updated_at
        ]
      end

      # Gọi hàm render_table từ CommonUtils với chế độ ép ngang
      CommonUtils.render_table(header, rows)
    rescue StandardError => e
      puts "Error listing books: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.stats
      DatabaseConnection.connect
      total_books = Book.count
      read_books = ReadingProgress.where(status: 'read').count
      reading_books = ReadingProgress.where(status: 'reading').count
      unread_books = ReadingProgress.where(status: 'unread').count

      puts "Total books: #{total_books}"
      puts "Books read: #{read_books}"
      puts "Books reading: #{reading_books}"
      puts "Books unread: #{unread_books}"
    rescue StandardError => e
      puts "Error generating stats: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end

    def self.show_progress(id)
      DatabaseConnection.connect
      book = Book.includes(:reading_progress).find_by(id: id)

      if book.nil?
        puts "Book not found: #{id}"
        return
      end

      if book.reading_progress.nil?
        puts "No reading progress for '#{book.title}'."
      else
        header = %w[id book_id status pages_read total_pages read created_at updated_at]
        progress = book.reading_progress
        pages_read = progress.pages_read
        total_pages = progress.total_pages
        read = "#{pages_read}/#{total_pages}"

        rows = [
          [
            book.id,
            book.title,
            progress.status,
            pages_read,
            total_pages,
            read,
            book.reading_progress.created_at,
            book.reading_progress.updated_at
          ]
        ]

        CommonUtils.render_table(header, rows)
      end
    rescue StandardError => e
      puts "Error showing progress: #{e.message}"
    ensure
      DatabaseConnection.disconnect
    end
  end
end
