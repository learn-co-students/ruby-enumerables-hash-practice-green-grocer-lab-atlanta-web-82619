require "pry"

my_cart = {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]

def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |hash|
    hash.each do |key, value|
      if updated_cart[key]
        updated_cart[key][:count] += 1
      else
        updated_cart[key] = value
        updated_cart[key][:count] = 1
      end
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  name = coupon[:item]
  if cart.include?(name) && cart[name][:count] >= coupon[:num]
      cart[name][:count] -= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += coupon[:num]
      else
        cart["#{name} W/COUPON"] = {
          :price => coupon[:cost] / coupon[:num],
          :clearance => cart[name][:clearance],
          :count => coupon[:num]
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = info[:price] * 80/100
    end
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0
  new_cart.each do |item, info|
    total = total + info[:price] * info[:count]
  end
  if total > 100
    total = total * 90/100
  end
  total
end
