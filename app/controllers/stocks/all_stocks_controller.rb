module Stocks
  class AllStocksController < ApplicationController
    def all
      @stocks = Stock.all
      @emergency_kits = EmergencyKit.all
    end
  end
end
