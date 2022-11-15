# frozen_string_literal: true

require_relative 'parser'

# Responsible for communication with the User
class Interlocutor
  DEFAULT_FILE_DIR = 'data/webserver.log'
  CEILING_PAGE_NAME_LENGTH = 7

  def converse
    file_dir = read_file_dir
    data = Parser.new(file_dir).parse

    puts "\nResults:\n\n"
    printout_results(data, :total, 'List of webpages with most page views:')
    puts "\n\n"
    printout_results(data, :uniq, 'List of webpages with unique page views:')
  end

  private

  def read_file_dir
    puts "Please type file direction or leave it empty for taking default direction #{DEFAULT_FILE_DIR}"

    ARGF.each do |input|
      file_dir = input.strip
      return DEFAULT_FILE_DIR if file_dir.empty?

      return file_dir if File.exists?(file_dir)

      puts 'You entered nonexistent file direction, please try again:'
    end
  end

  def printout_results(data, type, msg)
    puts msg
    puts "Page \t\t\t Views"
    data.sort_by{|_, values| -values[type]}.each do |page, values|
      tabs = page.length > CEILING_PAGE_NAME_LENGTH ? "\t\t " : "\t\t\t "
      puts "#{page}#{tabs}#{values[type]}"
    end
  end
end
