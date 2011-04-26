class OrdersController < ApplicationController

  load_and_authorize_resource

  # before_filter :authenticate_user!, :except => [:show]

  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all
    if params[:start_month].present? &&
       params[:start_year].present? &&
       params[:end_month].present? &&
       params[:end_year].present?
      starting = Date.civil(params[:start_year].to_i, params[:start_month].to_i =)
      ending = Date.civil(params[:end_year].to_i, params[:end_month].to_i =1)
    else
      starting = Date.today - 1000
      ending = Date.today
    end
    
    @order_list = Order.where(["date between ? AND ?", starting, ending ]).all
    @order_revenue_list = Order.sum(:revenue, :conditions => ["date between ? AND ?", starting, ending ])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # def index
  #   @orders = current_user.orders
  # end
  # 
  # 
  # def new
  #   @order = current_user.orders.build
  # end
  # 
  # def create
  #   @order = current_user.orders.build(params[:order])
  #   if @order.save
  #     redirect_to root_path
  #   else
  #     render 'new'
  #   end
  # end




  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    authorize! :update, @order
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
end
