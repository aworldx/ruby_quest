require './movie_collection'
require './netflix'
require './theatre'

movies = MyCinema::MovieCollection.new()
movies.read_from_file('movies.txt')

netflix = MyCinema::Netflix.new(movies)
netflix2 = MyCinema::Netflix.new(movies)

netflix.pay(10)
puts netflix.cash
netflix2.pay(10)
puts netflix.cash

begin
  netflix.show(genre: 'Comedy')
rescue => e
  puts e.message
end

netflix.how_much?('Forrest Gump')

theatre = MyCinema::Theatre.new(movies)
puts theatre.cash
theatre2 = MyCinema::Theatre.new(movies)
puts theatre2.cash
theatre.buy_ticket
puts theatre.cash
theatre2.buy_ticket
puts theatre2.cash

theatre.show
theatre.when?('Back to the Future')
