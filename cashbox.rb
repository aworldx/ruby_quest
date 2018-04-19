module Cashbox
  def add_cash(money)
    self.balance += Money.new(100 * money, "USD")
  end

  def take(who)
    if who == "Bank"
      puts 'encashment'
      self.balance = Money.new(0, "USD")
    else
      raise 'u-u-u-u-u-u-u'
    end
  end
end
