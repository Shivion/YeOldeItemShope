class ReadController < ApplicationController
  def front_page
    @items = Item.all
    @new_items = Item.order(:date_created)
  end
  def index
    @items = Item.all
  end
end
