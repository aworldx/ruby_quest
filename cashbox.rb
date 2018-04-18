require 'money'

module MyCinema
  module Cashbox
    # attr_reader :cash
    # def self.extended(base)
    #   base.setup
    # end

    # def setup
    #   @cash = Money.new(0, "USD")
    # end

    def cash
      @cash
    end

    def self.included(base)
      @cash = Money.new(0, "USD")
    end

    def top_up_balance(money)
      @cash += Money.new(100 * money, "USD")
    end

    def debit(money)
      m = Money.new(100 * money, "USD")
      @cash >= m && @cash -= m
    end

    def take(who)
      if who == "Bank"
        puts 'encashment'
        @cash = Money.new(0, "USD")
      else
        raise 'u-u-u-u-u-u-u'
      end
    end

    def buy_ticket
      top_up_balance(ticket_cost)
      self.now_showing_movie
      puts "You bought the ticket on #{@now_showing.title} movie"
    end

    def ticket_cost
      case Time.now.hour
      when 8..12
        3
      when 13..20
        5
      else
        10
      end
    end

    def pay(money)
      top_up_balance(money)
    end

    def price(movie_period)
      {
        ancient: 5,
        classic: 10,
        modern: 15,
        new: 20
      }.fetch(movie_period)
    end
  end
end
