# frozen_string_literal: true

require_relative 'lib/book_reading_tracker_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'book_reading_tracker_gem'
  spec.version       = BookReadingTrackerGem::VERSION
  spec.authors       = ['Doan Vo Van Trong']
  spec.email         = ['trong.doan@tomosia.com']

  spec.summary       = 'A CLI gem to track your book reading progress, authors, and categories.'
  spec.description   = 'BookReadingTrackerGem is a simple command-line Ruby gem that helps users manage their reading progress, books, authors, and categories. Built with Thor and ActiveRecord, and backed by a PostgreSQL (Supabase) database.'
  spec.homepage      = 'https://github.com/vantrong24052003/Book-Reading-Tracker-Gem'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/vantrong24052003/Book-Reading-Tracker-Gem'
  spec.metadata['changelog_uri']     = 'https://github.com/vantrong24052003/Book-Reading-Tracker-Gem/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
