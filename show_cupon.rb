# Check if quantity is above needed
def itemHasMoreThenQuantity?(qty)
  formula_products_vendor = ["Product Vendor List"]
  flag = false
  itemQty = 0
  Input.cart.line_items.each do |item|
    if  formula_products_vendor.include?(item.variant.product.vendor) && item.variant.product.product_type == "Formula"
      itemQty = itemQty + item.quantity
    end
  end
  if itemQty >= qty
    return true
  else 
    return false
  end
end

# Check if the products price adds up to total or more
def itemPriceIsMoreThen?(total)
  formula_products_vendor = ["Product vendor List"]
  sum_price = Money.zero
  for item in Input.cart.line_items
    if  formula_products_vendor.include?(item.variant.product.vendor) && item.variant.product.product_type == "Comida"
      sum_price = sum_price + item.line_price
    end
  end
  if sum_price >= total
    return true
  else 
    return false
  end
end

=begin 
  Here you can put the logic to use in case of a certain item being added to which you want to offer a certain cupon. 
  You can add the cupon in a message to the properties and the client will see it on the checkout and on the cart if your cart is configured to show them.
  Also disable the cupon in case the requirements are not met. Notice how in this example, Im looking for a Shipping discount
=end
if itemHasMoreThenQuantity?(2) || productHas85Gerber?(Money.new(cents: 1000))
  item = Input.cart.line_items.last
  new_properties = item.properties
  new_properties.merge!({"Message title" => "Message you want to show your customers to apply cupon"})
  item.change_properties(new_properties, message: "Property was added sucsefully")
elsif (Input.cart.discount_code)
  # If conditions are not met, make sure discount code is disabled.
  if Input.cart.discount_code.is_a?(CartDiscount::Shipping)
    if Input.cart.discount_code.code.casecmp("CODE_NAME") == 0
      Input.cart.discount_code.reject(message: "Reason why the discount code was not applied")
    end 
  end
end

Output.cart = Input.cart