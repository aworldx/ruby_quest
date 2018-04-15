require 'money'

module MyCinema
  module Cashbox
    def self.extended(base)
      base.setup
    end

    def setup
      @cash = Money.new(0, "USD")
    end

    def cash
      @cash.to_i
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
  end
end
