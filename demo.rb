require './movie_collection'
require './netflix'
require './theatre'

movies = MovieCollection.new()
movies.read_from_file('movies.txt')

netflix = Netflix.new(movies)
netflix.pay(10)
netflix.show(genre: 'Comedy', country: 'USA')

netflix.how_much?('Forrest Gump')

theatre = Theatre.new(movies)
theatre.show(Time.now)
theatre.when?('Back to the Future')

