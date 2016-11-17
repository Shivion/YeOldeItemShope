class ReadController < ApplicationController
  def front_page
    @staff_items = Item.joins(category_item: :category)\
      .where(categories: {name: 'Staff Picks'}).limit(5)
    @new_items = Item.order(created_at: :desc).limit(5)
    get_categories
  end
  def index
    if(!params["category"].nil? | !params["category"] == "") then
      @items = Item.joins(category_item: :category)\
        .where("categories.name IS ? AND items.name LIKE ?"\
        ,*["#{params["category"]}","%#{params["search"]}%"])
    else
      @items = Item.where("name LIKE ?", "%#{params["search"]}%")
    end
    get_categories
  end
  def new_items
    @items = Item.order(created_at: :desc)
    get_categories
  end
  def item
    @item = Item.where("name IS ?", "#{params["item"]}").first
    get_categories
  end
  def other
    @page = Page.where("name IS ?", "#{params["page"]}").first
    get_categories
  end
  private def get_categories
    @categories = Category.all
  end
end
