# frozen_string_literal: true

# db/seeds.rb

require_relative '../lib/book_reading_tracker_gem/models/book'
require_relative '../lib/book_reading_tracker_gem/models/author'
require_relative '../lib/book_reading_tracker_gem/models/book_author'
require_relative '../lib/book_reading_tracker_gem/models/category'
require_relative '../lib/book_reading_tracker_gem/models/book_category'
require_relative '../lib/book_reading_tracker_gem/models/reading_progress'

# Xóa dữ liệu cũ
dependencies = [ReadingProgress, BookCategory, BookAuthor, Category, Author, Book]
dependencies.each(&:destroy_all)

# Tạo dữ liệu mới
book1 = Book.create!(title: 'Ruby Basics', description: 'Learn Ruby', isbn: '1234567890', published_year: 2021)
book2 = Book.create!(title: 'Rails Advanced', description: 'Mastering Rails', isbn: '0987654321', published_year: 2022)

author1 = Author.create!(author_name: 'John Doe', biography: 'Ruby developer')
author2 = Author.create!(author_name: 'Jane Smith', biography: 'Rails expert')

category1 = Category.create!(category_name: 'Programming')
category2 = Category.create!(category_name: 'Web Development')

# Liên kết sách với tác giả
BookAuthor.create!(book: book1, author: author1)
BookAuthor.create!(book: book1, author: author2)
BookAuthor.create!(book: book2, author: author2)

# Liên kết sách với thể loại
BookCategory.create!(book: book1, category: category1)
BookCategory.create!(book: book2, category: category2)

# Tạo tiến độ đọc
ReadingProgress.create!(book: book1, status: 'reading', pages_read: 50, total_pages: 200, started_at: Date.today - 7)
ReadingProgress.create!(book: book2, status: 'unread', pages_read: 0, total_pages: 300)
