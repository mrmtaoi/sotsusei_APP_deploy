class ItemsController < ApplicationController
  def search
    keyword = params[:keyword]
    @items = if keyword.present?
               RakutenWebService::Ichiba::Item.search(keyword: keyword)
             else
               []
             end
  end
end
