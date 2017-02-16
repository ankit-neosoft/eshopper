class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /brands
  # GET /brands.json
  def index
    @categories = Category.all.where(parent_id: nil)
    @category = Category.first
    @brands = Brand.where(status: true).all
    @brand = Brand.find(params[:id])
    @cart_item = CartItem.new
    @products = @brand.products
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @categories = Category.all.where(parent_id: nil)
    cat_id = params[:subcategory_id] || params[:category_id]
    @category = Category.find(cat_id)
    @brand = Brand.find(params[:id])
    @products = @category.products.where(brand_id: @brand.id)
    @cart_item = CartItem.new

    if user_signed_in?
      @cart_items = current_user.cart_items.all
      @wishlists = current_user.wishlists
    end
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
      @brands = Brand.where(status: true).all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.fetch(:brand, {})
    end
end
