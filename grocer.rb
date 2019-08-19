def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |item|
    item.each do |key, value|
      if cart_hash[key]
        cart_hash[key][:count] += 1
      else
        cart_hash[key] = value
        cart_hash[key][:count] = 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart[coupon[:item]] and (cart[coupon[:item]][:count] >= coupon[:num])
         if cart["#{coupon[:item]} W/COUPON"] 
           cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]
         else
           x = "#{coupon[:item]} W/COUPON"
           cart[x] = {}
           cart[x][:price] = (coupon[:cost] / coupon[:num])
           cart[x][:clearance] = cart[coupon[:item]][:clearance]
           cart[x][:count] = coupon[:num]
         end
      cart[coupon[:item]][:count] -= coupon[:num]
    end
  end
  return cart
end 

def apply_clearance(cart)
  cart.each do |key, value|
     if value[:clearance] == TRUE
       value[:price] = (value[:price] *0.8).round(2)
     end
   end
   return cart
 end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  
  cart.each do |key, value|
    total += (value[:price] * value[:count])
  end
  
  if total > 100
    total = (total * 0.9).round(2)
  end
  return total
end