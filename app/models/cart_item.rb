class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  before_save { |ci| ci.total = ci.quantity * ci.product.price }

  def self.calculate_sum(coupon)
    coupon = Coupon.find_by(code: coupon)

    cart_items_total = sum(:total)
    if coupon.present?
      discount_amount = coupon.percent_off / 100 * cart_items_total 
      vat = 0.04 * (cart_items_total - discount_amount)
    else
      discount_amount = 0
      vat = 0.04 * cart_items_total
    end
    
    if cart_items_total < 500
      shipping_cost = 40.to_f
      grand_total = cart_items_total + vat + shipping_cost - (discount_amount if discount_amount.present?)
    else
      shipping_cost = 'Free'
      grand_total = cart_items_total + vat - (discount_amount if discount_amount.present?)
    end

    [cart_items_total, vat, shipping_cost, grand_total, discount_amount]
  end

  def self.calculates
    sum(:total)
  end
  
  # default_scope -> {where(user_id: current_user.id)}
end
