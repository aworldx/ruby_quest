require './movie_collection'
require './netflix'
require './theatre'

movies = MovieCollection.new()
movies.read_from_file('movies.txt')

netflix = Netflix.new(movies)
netflix2 = Netflix.new(movies)
puts Netflix.cash
netflix.pay(10)
puts Netflix.cash
netflix2.pay(10)
puts Netflix.cash


theatre = Theatre.new(movies)
theatre2 = Theatre.new(movies)
theatre.buy_ticket

puts theatre.cash

theatre2.buy_ticket

puts theatre2.cash

# netflix.pay(100)

# begin
#   netflix.show(genre: 'Comedy')
# rescue => e
#   puts e.message
# end

# netflix.how_much?('Forrest Gump')


# theatre.show(Time.now)
# theatre.when?('Back to the Future')
