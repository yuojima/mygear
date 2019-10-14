class GearsController < ApplicationController

  def new
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
end