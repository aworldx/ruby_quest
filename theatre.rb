class Theatre
  def initialize(movie_collection)
    @movie_collection = movie_collection
  end

  def show
    "Now showing: (название выбранного кина) (время начала) - (время окончания)"
  end
end
