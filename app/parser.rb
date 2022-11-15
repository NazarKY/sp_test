# frozen_string_literal: true

class Parser
  def initialize(file_dir)
    @file_dir = file_dir
  end

  def parse
    formatted_data
  end

  private

  def file
    @file ||= File.open(@file_dir)
  end

  def page_views
    file.readlines.map(&:split).group_by(&:first)
        .map { |key, array| [key, array.map(&:last)] }.to_h
  end

  def formatted_data
    @formatted_data ||= page_views.each_with_object({}) do |(key, value), hash|
      hash[key] = { total: value.size, uniq: value.uniq.size }
    end
  end
end
