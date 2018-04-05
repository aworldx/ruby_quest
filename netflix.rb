require 'byebug'

class Netflix
  def initialize(movie_collection)
    @movie_collection = movie_collection
    @account = 0
  end

  def show(options)
    @now_showing = @movie_collection.filter(options).sample

    if @now_showing
      unless charge(@now_showing.period)
        puts "Insufficient funds on the account. You have #{@account}.
          You need #{price(@now_showing.period)}"
        return
      end

      puts "Now showing: #{@now_showing.title} 21.00 - 23.00"
    else
      puts 'Sorry, we did not find the movie on your request'
    end
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
    if @account >= cost
      @account -= cost
      return true
    end
    false
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
