class ReadController < ApplicationController
  def front_page
    find_cart
    @staff_items = Item.joins(category_item: :category)\
      .where(categories: {name: 'Staff Picks'}).limit(5)
    @new_items = Item.order(created_at: :desc).limit(5)
    @items_on_sale = Item.where('percentage_off > 0').limit(5)
    get_categories
  end
  def index
    find_cart
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
    find_cart
    @items = Item.order(created_at: :desc)
    get_categories
  end
  def items_on_sale
    find_cart
    @items = Item.where('percentage_off > 0')
    get_categories
  end
  def item
    find_cart
    @item = Item.where("name IS ?", "#{params["item"]}").first
    get_categories
  end
  def other
    find_cart
    @page = Page.where("name IS ?", "#{params["page"]}").first
    get_categories
  end
  def edit_customer
    find_cart
    if(user_signed_in?) then
      @user = Customer.where(:email => current_user.email).first
      if(@user.nil?) then
        @user = Customer.new
        @user.email = current_user.email
        @user.address = "Address"
      end
    end
    get_categories
  end
  def new_customer
    find_cart
    @user = Customer.where(:email => params['email']).first
    if(@user.nil?) then
      @user = Customer.new
    end
    @user.email =  params['email']
    @user.address = params['address']
    @user.save
    get_categories
  end
  def remove_item_from_cart
    find_cart
    @new_item = OrderItem.where("item_id IS ? AND order_id IS ?",\
    *"#{[params['item_id']}", "#{@cart.id}"])
    @new_item.item_id = params['item_id']
    @new_item.order_id = @cart.id
    @new_item.save
  end
  def add_item_to_cart
    find_cart
    @new_item = OrderItem.new
    @new_item.item_id = params['item_id']
    @new_item.order_id = @cart.id
    @new_item.save
  end
  def cart
    find_cart
    @order_items = OrderItem.joins(order_item: :orders)\
    .where(:order_id => @cart.id)
    @items = Array.new
    @order_items.each do |order_item|
      @items.push(Item.where(:id = order_item.id).first)
    end
  end
  private def get_categories
    @categories = Category.all
  end
  private def find_cart
    @cart = Order.joins(:customers,order_item: :orders)\
      .where("customer.email IS ?",current_user.email).first(1)
    if(@cart.nil?) then
      @cart = Order.new
      @cart.customer = Customer.where(:email => current_user.email)
      @cart.save
    end
  end
end
