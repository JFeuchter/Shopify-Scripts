#Free sheeping if a product is in the cart

#Function to see if product is in cart
def cartHasProduct?
  for item in Input.cart.line_items
    #Can be changed to product vendor, tags, min cart price or product type
    #Change the product.id for the real id of a specific product
    if  item.variant.product.id == {{ product.id }}
      return true
    end
  end
  return false
end

#Function which 
def freeShippinng
  Input.shipping_rates.each do |shipping_rate|
    if shipping_rate.source.include?('shopify')
      shipping_rate.apply_discount(shipping_rate.price, message: "¡Envio Gratis!")
    end
  end
end

#puts cartHasNido?

customer = Input.cart.customer

#puts customer.orders_count

if  customer
  order_count = customer.orders_count
else
  order_count = 0
end
unless order_count != 0
  #puts "flag no customer or new customer"
  if cartHasNido?
    if (Input.cart.discount_code)
      #Input.cart.discount_code.reject(message: "Tu carrito ya cuenta con descuento de envio gratis.")
      #freeShippinng
    else
      freeShippinng
    end
  end
end

Output.shipping_rates = Input.shipping_rates