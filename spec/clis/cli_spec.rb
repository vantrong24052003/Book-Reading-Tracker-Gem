# frozen_string_literal: true

require 'rspec'
require 'book_reading_tracker_gem/clis/cli'

module BookReadingTrackerGem
  RSpec.describe CLI do
    # described_class.new  ===  cli = CLI.new
    let(:cli) { described_class.new }

    before do
      allow(BookService).to receive(:add_book)
      allow(BookService).to receive(:remove_book)
      allow(BookService).to receive(:update_progress)
      allow(BookService).to receive(:list_books)
      allow(BookService).to receive(:stats)
      allow(BookService).to receive(:show_progress)

      allow(AuthorService).to receive(:add_author)
      allow(AuthorService).to receive(:list_authors)

      allow(CategoryService).to receive(:add_category)
      allow(CategoryService).to receive(:list_categories)
    end

    describe '#add_book' do
      it 'calls BookService.add_book with correct arguments' do
        cli.invoke(:add_book, ['Ruby Programming'], author: 'David', pages: 300, description: 'Learn Ruby',
                                                    isbn: '1234567890', published_year: 2023)
        expect(BookService).to have_received(:add_book).with('Ruby Programming', 'David', 300, 'Learn Ruby',
                                                             '1234567890', 2023)
      end
    end

    describe '#remove_book' do
      it 'calls BookService.remove_book with correct ID' do
        cli.invoke(:remove_book, [1])
        expect(BookService).to have_received(:remove_book).with(1)
      end
    end

    describe '#progress_book' do
      it 'calls BookService.update_progress with correct arguments' do
        cli.invoke(:progress_book, [2], page: 150)
        expect(BookService).to have_received(:update_progress).with(2, 150)
      end
    end

    describe '#list_books' do
      it 'calls BookService.list_books' do
        cli.invoke(:list_books)
        expect(BookService).to have_received(:list_books)
      end
    end

    describe '#stats' do
      it 'calls BookService.stats' do
        cli.invoke(:stats)
        expect(BookService).to have_received(:stats)
      end
    end

    describe '#show_progress' do
      it 'calls BookService.show_progress with correct ID' do
        cli.invoke(:show_progress, [3])
        expect(BookService).to have_received(:show_progress).with(3)
      end
    end

    describe '#add_author' do
      it 'calls AuthorService.add_author with correct arguments' do
        cli.invoke(:add_author, ['J.K. Rowling'], biography: 'Author of Harry Potter')
        expect(AuthorService).to have_received(:add_author).with('J.K. Rowling', 'Author of Harry Potter')
      end
    end

    describe '#list_authors' do
      it 'calls AuthorService.list_authors' do
        cli.invoke(:list_authors)
        expect(AuthorService).to have_received(:list_authors)
      end
    end

    describe '#add_category' do
      it 'calls CategoryService.add_category with correct name' do
        cli.invoke(:add_category, ['Fiction'])
        expect(CategoryService).to have_received(:add_category).with('Fiction')
      end
    end

    describe '#list_categories' do
      it 'calls CategoryService.list_categories' do
        cli.invoke(:list_categories)
        expect(CategoryService).to have_received(:list_categories)
      end
    end
  end
end
