my_cart = [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]

def apply_coupons(cart, coupons)
  cart_w_coupons = {}
  cart.each do |item, info|
    coupons.each do |coupon|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] -= coupon[:num]
        if cart_w_coupons["#{item} W/COUPON"]
          cart_w_coupons["#{item} W/COUPON"][:count] += 1
          cart_w_coupons[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
          #cart_w_coupons["#{item} W/COUPON"] ||= {}
          cart_w_coupons["#{item} W/COUPON"][:price] = coupon[:cost]
          cart_w_coupons["#{item} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
          #cart_w_coupons["#{item} W/COUPON"][:count] ||= 0
          cart_w_coupons["#{item} W/COUPON"][:count] += 1
        else
          cart_w_coupons["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    cart_w_coupons[item] = info
    p cart_w_coupons
  end
  cart_w_coupons
end

puts apply_coupons(my_cart, coupons)




  # code here
end
