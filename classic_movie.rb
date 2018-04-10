class ClassicMovie < Movie
  def initialize(options, movie_collection)
    super(options)
    @movie_collection = movie_collection
    @period = :classic
  end

  def to_s
    title = "#{@title} — классический фильм, режиссёр #{@producer}. Остальные фильмы режиссёра:\n"
    
    @movie_collection.filter(producer: @producer).each do |movie|
        title += "#{movie.title}\n" unless movie.title == @title
    end

    title
  end
end
