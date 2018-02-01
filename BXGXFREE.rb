
#Edited Script from BOGO example script
PAID_ITEM_COUNT = 0
DISCOUNTED_ITEM_COUNT = 0
DISCOUNTED_ITEMS_SEEN = 0
DISCOUNT_VENDOR = "Vendor Name"
ITEM_NUM_TO_FREE = 3

#gets if cart has needed vendor to apply discount
def cart_has_vendor?
  Input.cart.line_items.each do |item|
    #Can be done for tags min price or product type etc
    if  item.variant.product.vendor == DISCOUNT_VENDOR
      return true 
    end
  end
  return false
end 

# Partitions the items and returns the items that are to be discounted.
#
# Arguments
# ---------
#
# * cart
#   The cart to which split items will be added (typically Input.cart).
#
# * line_items
#   The selected items that are applicable for the campaign.
#
def partition(cart, line_items)
  # Sort the items by price from low to high
  sorted_items = line_items.sort_by{|line_item| line_item.variant.price}
  # Create an array of items to return
  discounted_items = []

  # Loop over all the items and find those to be discounted
  sorted_items.each do |line_item|
    count = DISCOUNTED_ITEM_COUNT
    # If there are none, skip to the next item
    next if count <= DISCOUNTED_ITEMS_SEEN

    if count >= line_item.quantity
      # If the full item quantity must be discounted, add it to the items to return
      # and increment the count of discounted items
      discounted_items.push(line_item)
      DISCOUNTED_ITEMS_SEEN += line_item.quantity
    else
      # If only part of the item must be discounted, split the item
      discounted_item = line_item.split(take: count - DISCOUNTED_ITEMS_SEEN)
      # Insert the newly-created item in the cart, right after the original item
      position = cart.line_items.find_index(line_item)
      cart.line_items.insert(position + 1, discounted_item)
      # Add it to the list of items to return
      discounted_items.push(discounted_item)
      DISCOUNTED_ITEMS_SEEN += discounted_item.quantity
    end
  end

  # Return the items to be discounted
  discounted_items
end

# get_total_disc_num gets the number of items which will are in the promotion.
def get_total_disc_num
  Input.cart.line_items.each do |item|
    if  item.variant.product.vendor == DISCOUNT_VENDOR
      PAID_ITEM_COUNT = PAID_ITEM_COUNT + item.quantity
    end
  end
  DISCOUNTED_ITEM_COUNT = (PAID_ITEM_COUNT/ITEM_NUM_TO_FREE).floor
end

if cart_has_vendor?
  if get_total_disc_num >= 1
    eligible_items = Input.cart.line_items.select do |line_item|
      product = line_item.variant.product
      !product.gift_card? && product.vendor  == DISCOUNT_VENDOR
    end

    discounted_line_items = partition(Input.cart, eligible_items)
    discounted_line_items.each do |line_item|
      line_item.change_line_price(Money.zero, message: "Descuento 3x2 en Vendor")
    end
  end
end

Output.cart = Input.cart
