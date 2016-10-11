# Check for the percetnage case in the cupon. It can be used as well with the 
case Input.cart.discount_code
when CartDiscount::Percentage
  discount_code_string = Input.cart.discount_code.code
  if discount_code_string.include? "cupon_name"
    discount_flag = false
    item_highest_price = Money.zero
    item_highest_id = 0
    # This for gets the highest priced product and assueres there is a discount to apply
    for item in Input.cart.line_items
      if  item.variant.product.vendor == "vendor_name"
        if item_highest_price < item.variant.price
          unless item.variant.product.tags.include?("any_items_not_to_be_included")
            item_highest_id = item.variant.id
            item_highest_price = item.variant.price
            discount_flag = true
          end
        end
      end
    end
    # Check if discount will be applied
    if discount_flag
      # This for applies the discount and the message via the LineItem properties
      for item in Input.cart.line_items
        if item.variant.id == item_highest_id
          item.change_line_price(item.line_price - item.variant.price, message: "Se aplico descuento del cupon")
          new_properties = item.properties
          new_properties.merge!({"Descuento" => "SE APLICO EL DESCUENTO DEL CUPÓN"})
          item.change_properties(new_properties, message: "Se aplico el descuento")
        end
      end
    end
  end
end

Output.cart = Input.cart