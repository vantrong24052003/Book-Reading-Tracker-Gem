# frozen_string_literal: true

require 'tty-table'

module CommonUtils
  def self.render_table(header, rows)
    if rows.empty?
      puts 'No data available.'
    else
      table = TTY::Table.new(header, rows)
      puts table.render(:unicode, resize: false, alignments: %i[center])
    end
  end
end
