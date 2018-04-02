require './movie_collection'

movies = MovieCollection.new('movies.txt')
puts movies
puts movies.all
puts movies.sort_by(:genre)
puts movies.filter(year: '1921')
puts movies.stats(:producer)
puts movies.all.first.actors

begin
  puts movies.all.first.has_genre?('Tragedy')
rescue Exception => e  
  puts e.message  
end  
