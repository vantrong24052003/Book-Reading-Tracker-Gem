# frozen_string_literal: true

require_relative '../lib/book_reading_tracker_gem/models/book'
require_relative '../lib/book_reading_tracker_gem/models/author'
require_relative '../lib/book_reading_tracker_gem/models/book_author'
require_relative '../lib/book_reading_tracker_gem/models/category'
require_relative '../lib/book_reading_tracker_gem/models/book_category'
require_relative '../lib/book_reading_tracker_gem/models/reading_progress'

class Seeder
  def self.run
    dependencies = [ReadingProgress, BookCategory, BookAuthor, Category, Author, Book]
    dependencies.each(&:destroy_all)

    book1 = Book.create!(title: 'Ruby Basics', description: 'Learn Ruby', isbn: '1234567890', published_year: 2021)
    book2 = Book.create!(title: 'Rails Advanced', description: 'Mastering Rails', isbn: '0987654321',
                         published_year: 2022)

    author1 = Author.create!(author_name: 'John Doe', biography: 'Ruby developer')
    author2 = Author.create!(author_name: 'Jane Smith', biography: 'Rails expert')

    category1 = Category.create!(category_name: 'Programming')
    category2 = Category.create!(category_name: 'Web Development')

    BookAuthor.create!(book: book1, author: author1)
    BookAuthor.create!(book: book1, author: author2)
    BookAuthor.create!(book: book2, author: author2)

    BookCategory.create!(book: book1, category: category1)
    BookCategory.create!(book: book2, category: category2)

    ReadingProgress.create!(book: book1, status: 'reading', pages_read: 50, total_pages: 200,
                            started_at: Date.today - 7)
    ReadingProgress.create!(book: book2, status: 'unread', pages_read: 0, total_pages: 300)

    puts 'Đã seed dữ liệu thành công!'
  end
end
