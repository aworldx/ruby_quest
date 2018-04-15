require './movie_collection'
require './netflix'
require './theatre'

movies = MyCinema::MovieCollection.new()
movies.read_from_file('movies.txt')

netflix = MyCinema::Netflix.new(movies)
netflix2 = MyCinema::Netflix.new(movies)
netflix.pay(10)
netflix2.pay(10)

begin
  netflix.show(genre: 'Comedy')
rescue => e
  puts e.message
end

netflix.how_much?('Forrest Gump')

theatre = MyCinema::Theatre.new(movies)
theatre2 = MyCinema::Theatre.new(movies)
theatre.buy_ticket
theatre2.buy_ticket

theatre.show
theatre.when?('Back to the Future')
