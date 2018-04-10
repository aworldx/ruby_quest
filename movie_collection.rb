require 'csv'
require './movie'
require './new_movie'
require './ancient_movie'
require './classic_movie'
require './modern_movie'

class MovieCollection
  include Enumerable

  def initialize()
    @movies = []
  end

  def each(&block)
    @movies.each(&block)
  end

  def file_fields
    [:link, :title, :year, :country, :premiere_date, :genre, :durability, :rate, :producer, :actors]
  end

  def collection_fields
    file_fields << :period
  end

  def read_from_file(file_name)
    options = { headers: file_fields, converters: [:date], col_sep: '|' }

    CSV.foreach(file_name, options) do |row|
      row[:year] = row[:year].to_i
      row[:durability] = row[:durability].to_i
      row[:genre] = row[:genre].split(',')
      row[:actors] = row[:actors].split(',')
      row[:premiere_date] = format_date(row[:premiere_date]) if row[:premiere_date].is_a?(String)

      case row[:year]
      when 0..1944
        movie = AncientMovie.new(row.to_hash)
      when 1945..1967
        movie = ClassicMovie.new(row.to_hash, self)
      when 1968..1999
        movie = ModernMovie.new(row.to_hash)
      else
        movie = NewMovie.new(row.to_hash)
      end

      @movies << movie
    end

    @movies
  end

  def all
    @movies
  end

  def sort_by(*args)
    missing_fields = args - collection_fields
    raise ArgumentError, "Sorting by field #{missing_fields.to_s} is not possible" unless missing_fields.empty?

    self.sort_by do |movie|
      args.map do |sort_field|
        field_value = movie.send(sort_field)
        field_value.is_a?(Array) ? field_value.first : field_value
      end
    end
  end

  def filter(search)
    raise ArgumentError, "Filter: search must have hash type" unless search.is_a?(Hash)
    missing_fields = search.keys - collection_fields
    raise ArgumentError, "Filtering by field #{missing_fields} is not possible" unless missing_fields.empty?

    self.reject do |movie|
      # if at least one field does not match
      fields_match(movie, search).include?(false)
    end
  end

  def fields_match(movie, search)
    search.map do |search_key, search_value|
      movie_attr_value = movie.send(search_key)
      movie_attr_match_search_value?(movie_attr_value, search_value)
    end
  end

  def movie_attr_match_search_value?(movie_attr, search_value)
    if movie_attr.is_a?(Array)
      search_value.is_a?(Array) ? arrays_intersect?(movie_attr, search_value) : movie_attr.include?(search_value)
    else
      movie_attr == search_value
    end
  end

  def arrays_intersect?(ar1, ar2)
    (ar1 & ar2).size > 0
  end

  def stats(stat_field)
    raise ArgumentError, "Stats by field #{stat_field} is not possible" unless collection_fields.include?(stat_field)

    stat = {}
    groups = self.group_by { |movie| movie.send(stat_field) }

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
