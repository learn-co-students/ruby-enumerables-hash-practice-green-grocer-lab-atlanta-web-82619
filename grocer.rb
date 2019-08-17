require "pry"
def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |food_item, price_hash|
      if consolidated_cart[food_item]
        consolidated_cart[food_item][:count] +=1 
      else
        consolidated_cart[food_item] = price_hash
        consolidated_cart[food_item][:count] = 1
      end
  end
end
   consolidated_cart   
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
   
    if cart.keys.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      
      if cart.keys.include?("#{coupon[:item]} W/COUPON")
      cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
      
      else 
        cart["#{coupon[:item]} W/COUPON"] = {
        :price => coupon[:cost]/coupon[:num], 
        :clearance => cart[coupon[:item]][:clearance],
        :count => coupon[:num]
      }
      
    end
      cart[coupon[:item]][:count] -= coupon[:num]
    end
   end
  cart
end

def apply_clearance(cart)
  cart.each do |food_item, attribute_hash|
    if attribute_hash[:clearance] == true 
      attribute_hash[:price] = (attribute_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  clearance_cart.each do |item, attribute_hash|
    total += (attribute_hash[:price] * attribute_hash[:count])
  end
  
  total = (total * 0.9) if total > 100
  total
 # binding.pry
end
