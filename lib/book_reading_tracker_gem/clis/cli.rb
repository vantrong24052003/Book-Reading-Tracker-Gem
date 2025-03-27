# frozen_string_literal: true

require 'thor'
require_relative '../services/book_service'
require_relative '../services/author_service'
require_relative '../services/category_service'

module BookReadingTrackerGem
  class CLI < Thor
    # Quản lý sách
    desc 'add_book TITLE --author AUTHOR --pages PAGES [--description DESCRIPTION] [--isbn ISBN] [--published_year YEAR]',
         'Thêm sách mới vào danh sách'
    option :author, required: true
    option :pages, required: true, type: :numeric
    option :description, required: false
    option :isbn, required: false
    option :published_year, required: false, type: :numeric
    def add_book(title)
      # ruby bin/remind add_book "Ruby Programming" --author "David Heinemeier Hansson" --pages 300 --description "Learn Ruby with Rails" --isbn "978-0134596882" --published_year 2023
      BookService.add_book(
        title,
        options[:author],
        options[:pages],
        options[:description],
        options[:isbn],
        options[:published_year]
      )
    end

    desc 'remove_book ID', 'Xóa sách khỏi danh sách'
    # ruby bin/remind remove_book 1
    def remove_book(id)
      BookService.remove_book(id)
    end

    desc 'progress_book ID --page PAGE', 'Cập nhật tiến độ đọc sách'
    option :page, required: true, type: :numeric
    def progress_book(id)
      # ruby bin/remind progress_book 2 --page 150
      BookService.update_progress(id, options[:page])
    end

    desc 'list_books', 'Hiển thị danh sách sách'
    # ruby bin/remind list_books
    def list_books
      BookService.list_books
    end

    desc 'stats', 'Hiển thị thống kê sách'
    # ruby bin/remind stats
    def stats
      BookService.stats
    end

    desc 'show_progress ID', 'Xem tiến độ đọc sách'
    # ruby bin/remind show_progress "Ruby Programming"
    def show_progress(id)
      BookService.show_progress(id)
    end

    # Quản lý tác giả
    desc 'add_author NAME [--biography BIOGRAPHY]', 'Thêm tác giả mới'
    option :biography, required: false
    def add_author(name)
      # ruby bin/remind add_author "J.K. Rowling" --biography "Tác giả của Harry Potter"
      AuthorService.add_author(name, options[:biography])
    end

    desc 'list_authors', 'Hiển thị danh sách tác giả'
    def list_authors
      # ruby bin/remind list_authors
      AuthorService.list_authors
    end

    # Quản lý danh mục
    desc 'add_category NAME', 'Thêm danh mục mới'
    def add_category(name)
      # ruby bin/remind add_category "Fiction"
      CategoryService.add_category(name)
    end

    desc 'list_categories', 'Hiển thị danh sách danh mục'
    # ruby bin/remind list_categories
    def list_categories
      CategoryService.list_categories
    end

    # Override Thor's error handling for invalid options
    def self.exit_on_failure?
      true
    end
  end
end
