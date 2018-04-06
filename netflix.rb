class Netflix
  attr_reader :account

  def initialize(movie_collection)
    @movie_collection = movie_collection
    @account = 0
  end

  def show(options)
    movies = @movie_collection.filter(options)
    now_showing = movies.sort_by { |m| m.rate }.first

    if now_showing
      raise "Insufficient funds on the account" unless charge(now_showing.period)

      puts "Netflix now showing: #{now_showing.title} 21.00 - 23.00"
    else
      puts 'Sorry, we did not find the movie on your request'
    end

    now_showing
  end

  def pay(money)
    @account += money
  end

  def price(movie_period)
    {
      ancient: 5,
      classic: 10,
      modern: 15,
      new: 20
    }.fetch(movie_period)
  end

  def charge(movie_period)
    cost = price(movie_period)
    return @account >= cost && @account -= cost
  end

  def how_much?(movie_title)
    movie = @movie_collection.filter(title: movie_title).first

    if movie
      puts "#{price(movie.period)} dollars"
    else
      puts "Sorry, we did not find the movie on your request"
    end
  end
end
