require 'csv'
require './movie'

class MovieCollection
  def initialize(file_name)
    @movies = []
    keys = [:link, :title, :year, :country, :premiere_date, :genre, :durability, :rate, :producer, :actors]
      
    options = { headers: keys, converters: [:date], col_sep: '|' }
      
    CSV.foreach(file_name, options) do |row|
      movie = Movie.new(row.to_hash)      
      @movies << movie
    end
  end

  def all
    @movies
  end

  def sort_by(movie_attr)
    
  end

  def filter(movie_attr)
    
  end

  def stats(movie_attr)

  end

  def to_s
    "Movie collection: #{@movies.size} movies"
  end

  def inspect
    "Movie collection: #{@movies.size} movies"
  end
end
