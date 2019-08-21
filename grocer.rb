def consolidate_cart(cart)
  output = {}
  cart.each do |item|
    item_name = item.keys[0]
    if output[item_name]
      output[item_name][:count] += 1 
    else
      output[item_name] = item[item_name]
      output[item_name][:count] = 1 
    end
  end
  output
end

def apply_coupons(cart, coupons)
  coupons.each |coupon| do
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
  return cart
end 

def apply_clearance(cart)
  
end

def checkout(cart, coupons)
  
end