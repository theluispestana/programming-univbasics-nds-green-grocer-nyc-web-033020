def find_item_by_name_in_collection(name, collection)
  # pp name
  # pp collection
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  while index < collection.length do
    return collection[index] if collection[index][:item] == name
    index += 1
  end
end

def find_index(name, collection)
  # pp name
  # pp collection
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  while index < collection.length do
    return index if collection[index][:item] == name
    index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  index = 0
  while index < cart.length do
    new_item = find_item_by_name_in_collection(cart[index][:item], new_cart)
    if new_item != nil
      new_item[:count] += 1
    else
      new_item = {
        item: cart[index][:item],
        price: cart[index][:price],
        clearance: cart[index][:clearance],
        count: 1
      }
      new_cart << new_item
    end
    index += 1
  end
  new_cart
end


# def apply_coupons(cart, coupons)
#   # Consult README for inputs and outputs
#   #
#   # REMEMBER: This method **should** update cart
#   index = 0
#   while index < coupons.length do
#     coupon = coupons[index]
#     matching_index = find_index(coupon[:item], cart)
#     if matching_index
#       cart[matching_index][:count] -= coupon[:num]
#       cart << {
#         item: "#{coupon[:item]} W/COUPON",
#         price: coupon[:cost] / coupon[:num],
#         clearance: cart[matching_index][:clearance],
#         count: coupon[:num]
#       }
#     end
#     index += 1
#   end
#   cart
# end

def apply_coupons(cart, coupons)
  counter = 0
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:coupon] += coupons[counter][:num]
        cart_item[:coupon] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          item: couponed_item_name,
          price: coupons[counter][:cost] / coupons[counter][:num],
          count: coupons[counter][:num],
          clearance: cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    item = cart[index]
    if item[:clearance]
      item[:price] -= (item[:price] * 0.2)
      item[:price].round(2)
    end
    index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  # final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_applied_cart)

  grand_total = 0
  index = 0
  while index < final_cart.length do
    item = final_cart[index]
    grand_total += item[:price] * item[:count]
    index += 1
  end
  grand_total -= grand_total * 0.1 if grand_total > 100
  grand_total
end
