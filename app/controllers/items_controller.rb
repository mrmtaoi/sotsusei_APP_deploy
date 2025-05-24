class ItemsController < ApplicationController
  def search
    keyword = params[:keyword]
    if keyword.present? && keyword.length >= 2
      @items = RakutenWebService::Ichiba::Item.search(keyword: keyword)
      @error_message = nil
    else
      @items = []
      @error_message = "検索ワードは2文字以上で入力してください"
    end
  end
end
