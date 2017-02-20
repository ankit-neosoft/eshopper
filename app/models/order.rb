class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  belongs_to :address
  has_one :payment_transaction
  belongs_to :coupon


  
  # has_many :addresses

  # before_save :update_sub_total

  # def sub_total
  #   order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  # end

  # def update_sub_total
  #   binding.pry
  #   self[:sub_total] = sub_total
  # end

  def track_status_enum
    ['ordered', 'shipped', 'delivered']
  end

  def status_enum
    ['cancelled', 'successful']
  end
end
