class Movie
  attr_accessor :link, :title, :year, :country
  attr_accessor :premiere_date, :genre, :durability, :rate
  attr_accessor :producer, :actors

  def initialize(options)
    @link = options[:link]
    @title = options[:title]
    @year = options[:year]
    @country = options[:country]
    @premiere_date = options[:premiere_date]
    @genre = options[:genre]
    @durability = options[:durability]
    @rate = options[:rate]
    @producer = options[:producer]
    @actors = options[:actors]
  end

  def avialable_genres
    ['Action', 'Crime', 'Drama', 'Biography', 'History', 'Western', 'Thriller', 'Comedy']
  end

  def has_genre?(genre_name)
    raise ArgumentError, 'Such genre does not exist' unless avialable_genres.include?(genre_name)
    @genre.include?(genre_name)
  end

  def to_s
    "#{@title} (#{@premiere_date}; #{@genre}) - #{@durability}"
  end
end
