class ItemsController < ApplicationController
  def search
    keyword = params[:keyword]
    if keyword.present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: keyword)
    else
      @items = []
    end
  end
end
