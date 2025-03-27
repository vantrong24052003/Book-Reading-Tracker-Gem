require 'thor'
require_relative '../services/book_service'
require_relative '../services/author_service'
require_relative '../services/category_service'

module BookReadingTrackerGem
  class CLI < Thor
    # Quản lý sách
    desc "add_book TITLE --author AUTHOR --pages PAGES [--description DESCRIPTION] [--isbn ISBN] [--published_year YEAR]", "Thêm sách mới vào danh sách"
    option :author, required: true
    option :pages, required: true, type: :numeric
    option :description, required: false
    option :isbn, required: false
    option :published_year, required: false, type: :numeric
    def add_book(title)
      BookService.add_book(
        title,
        options[:author],
        options[:pages],
        options[:description],
        options[:isbn],
        options[:published_year]
      )
      puts "Đã thêm sách: #{title}."
    end

    desc "remove_book TITLE", "Xóa sách khỏi danh sách"
    def remove_book(title)
      BookService.remove_book(title)
      puts "Đã xóa sách: #{title}."
    end

    desc "update_book TITLE --status STATUS", "Cập nhật trạng thái sách"
    option :status, required: true
    def update_book(title)
      BookService.update_status(title, options[:status])
      puts "Đã cập nhật trạng thái sách: #{title} thành #{options[:status]}."
    end

    desc "progress_book TITLE --page PAGE", "Cập nhật tiến độ đọc sách"
    option :page, required: true, type: :numeric
    def progress_book(title)
      BookService.update_progress(title, options[:page])
      puts "Đã cập nhật tiến độ đọc sách: #{title} đến trang #{options[:page]}."
    end

    desc "list_books", "Hiển thị danh sách sách"
    def list_books
      BookService.list_books
    end

    # Quản lý tác giả
    desc "add_author NAME [--biography BIOGRAPHY]", "Thêm tác giả mới"
    option :biography, required: false
    def add_author(name)
      AuthorService.add_author(name, options[:biography])
      puts "Đã thêm tác giả: #{name}."
    end

    desc "list_authors", "Hiển thị danh sách tác giả"
    def list_authors
      AuthorService.list_authors
    end

    # Quản lý danh mục
    desc "add_category NAME", "Thêm danh mục mới"
    def add_category(name)
      CategoryService.add_category(name)
      puts "Đã thêm danh mục: #{name}."
    end

    desc "list_categories", "Hiển thị danh sách danh mục"
    def list_categories
      CategoryService.list_categories
    end
  end
end
