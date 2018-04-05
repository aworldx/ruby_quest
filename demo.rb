require './movie_collection'

movies = MovieCollection.new()
movies.read_from_file('movies.txt')

# puts movies
# puts movies.all
# puts movies.sort_by(:genre, :year)
puts movies.filter(year: 1997, genre: 'Comedy')
# puts movies.stats(:producer)
# puts movies.all.first.actors

# begin
#   puts movies.all.first.has_genre?('Tragedy')
# rescue => e  
#   puts e.message  
# end  
