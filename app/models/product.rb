class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
  has_many :product_categories
  has_many :categories, :through=> :product_categories
  belongs_to :brand
  has_many :order_items

  has_many :product_wishlists
  has_many :wishlists, :through=> :product_wishlists

  default_scope{where(status: true)}
end
