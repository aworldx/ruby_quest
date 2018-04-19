module Cashbox
  def add_cash(money)
    self.balance += format_amount(money)
  end

  def format_amount(amount)
    Money.new(amount, "USD") * 100 
  end

  def take(who)
    if who == "Bank"
      puts 'encashment'
      self.balance = format_amount(0)
    else
      raise 'u-u-u-u-u-u-u'
    end
  end
end
