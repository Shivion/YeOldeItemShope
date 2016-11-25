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
    @user.name = "Blank Name"
    @user.save
    get_categories
  end
  def remove_item_from_cart
    find_cart
    item = OrderItem.where(:item_id => params['item'], :order_id => @cart.id).first
    item.quantity = params['quantity'].to_f
    item.save
    if !params['remove'].nil? then
      item.destroy
    end
    redirect_back fallback_location: cart_path
  end
  def add_item_to_cart
    find_cart

    item = OrderItem.where(:item_id => params['item'], :order_id => @cart.id).first
    if item.nil? then
      item = OrderItem.new
      item.item_id = params['item']
      item.order_id = @cart.id
      item.quantity = 1
      item.save
    else
      item.quantity += 1
      item.save
    end

    redirect_back fallback_location: front_page_path
  end
  def cart
    find_cart
    if(user_signed_in?) then
      @user = Customer.where(:email => current_user.email).first
      if(@user.nil?) then
        @user = Customer.new
        @user.email = current_user.email
        @user.address = ""
      end
    end
    @items = Item.joins(order_item: :order).where("Orders.id IS ?", @cart.id)
    @order_items = OrderItem.where(:order_id => @cart.id)
  end
  def checkout
    find_cart
    @cart.placed = true
    @cart.save
    redirect_back fallback_location: front_page_path
  end
  private def get_categories
    @categories = Category.all
  end
  private def find_cart
    if user_signed_in? then
      @cart = Order.joins(:customer)\
        .where("customers.email IS ? AND orders.placed IS NULL",current_user.email).first
      if(@cart.nil?) then
        @cart = Order.new
        @cart.customer = Customer.where(:email => current_user.email).first
        @cart.save
      end
      @order_items_count = OrderItem.where(:order_id => @cart.id).count
    end
  end
end
