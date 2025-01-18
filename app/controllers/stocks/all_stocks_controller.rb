class Stocks::AllController < ApplicationController
  def all
    @stocks = Stock.all
    @emergency_kits = EmergencyKit.all
  end
end
