class Netflix
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show(options)
    @movie_collection.filter(options)   
    # "Now showing: (название выбранного кина) (время начала) - (время окончания)"
  end
end
