require 'csv'
require './movie'

class MovieCollection
  def initialize(file_name)
    @movies = []
    keys = [:link, :title, :year, :country, :premiere_date, :genre, :durability, :rate, :producer, :actors]
      
    options = { headers: keys, converters: [:date], col_sep: '|' }
      
    CSV.foreach(file_name, options) do |row|
      row[:durability] = row[:durability].to_i
      row[:genre] = row[:genre].split(',')
      row[:actors] = row[:actors].split(',')
      row[:premiere_date] = format_date(row[:premiere_date]) if row[:premiere_date].is_a?(String)

      movie = Movie.new(row.to_hash)      
      @movies << movie
    end
  end

  def all
    @movies
  end

  def sort_by(sort_field)
    @movies.sort_by do |movie| 
      field_value = movie.send(sort_field)
      field_value.is_a?(Array) ? field_value.first : field_value
    end
  end

  def filter(options)
    @movies.select do |movie|
      movie.send(options.keys.first).include?(options.values.first)
    end  
  end

  def stats(stat_field)
    stat = {}
    groups = @movies.group_by { |movie| movie.send(stat_field) }
    
    groups.keys.each do |key| 
      stat[key] = groups[key].size
    end

    stat
  end

  def format_date(date)
    date_parts = date.split('-')
    add_parts = ['-01-01', '-01']
    
    date += add_parts.fetch(date_parts.size-1, '')
    Date.parse(date)
  end

  def to_s
    "Movie collection: #{@movies.size} movies"
  end
end
