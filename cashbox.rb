module Cashbox
  def self.extended(base)
    base.setup
  end

  def setup
    @cash = 0
  end

  def cash
    @cash
  end

  def top_up_balance(money)
    @cash += money
  end

  def debit(money)
    @cash -= money
  end
end
