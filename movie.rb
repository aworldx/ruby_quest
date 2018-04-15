module MyCinema
  class Movie
    attr_accessor :link, :title, :year, :country,
      :premiere_date, :genre, :durability, :rate,
      :producer, :actors, :period

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

    def to_h
      {
        link: @link,
        title: @title,
        year: @year,
        country: @country,
        premiere_date: @premiere_date,
        genre: @genre,
        durability: @durability,
        rate: @rate,
        producer: @producer,
        actors: @actors
      }
    end
  end
end
