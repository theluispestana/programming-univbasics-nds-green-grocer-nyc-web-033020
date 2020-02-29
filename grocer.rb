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


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < coupons.length do
    coupon = coupons[index]
    matching_index = find_index(coupon[:item], cart)
    if matching_index
      cart[matching_index][:count] -= coupon[:num]
      cart << {
        item: "#{coupon[:item]} W/COUPON",
        price: coupon[:cost] / coupon[:num],
        clearance: cart[matching_index][:clearance],
        count: coupon[:num]
      }
    end
    index += 1
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
      item[:price] -= item[:price] * .2
    end
  end
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
end
