module Cashbox
  def top_up_balance(money)
    self.balance += Money.new(100 * money, "USD")
  end

  def debit(money)
    m = Money.new(100 * money, "USD")
    self.balance >= m && self.balance -= m
  end

  def buy_ticket
    top_up_balance(self.ticket_cost)
    self.now_showing_movie
    puts "You bought the ticket on #{@now_showing.title} movie"
  end

  def pay(money)
    top_up_balance(money)
  end

  def charge(movie_period)
    cost = self.price(movie_period)
    debit(cost)
  end

  def take(who)
    if who == "Bank"
      puts 'encashment'
      @cash = Money.new(0, "USD")
    else
      raise 'u-u-u-u-u-u-u'
    end
  end
end
