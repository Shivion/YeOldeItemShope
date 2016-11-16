class ReadController < ApplicationController
  def front_page
    @staff_items = Item.joins(category_item: :category)\
      .where(categories: {name: 'Staff Picks'}).limit(5)
    @new_items = Item.order(created_at: :desc).limit(5)
  end
  def index
    @items = Item.all
  end
  def new_items
    @items = Item.order(created_at: :desc)
  end
  def category
    @items = Item.joins(category_item: :category)\
      .where(categories: {name: params[category]})
  end
end
