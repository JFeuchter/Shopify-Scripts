ReadMe

Here Ill be posting Shopify Scripts to help the comunity. If you have any questions about the scripts Ill be keeping tabs on the Issues. Any suggestions to better the code is more then welcome! :D 

Here Ill leave a few interesting links you might need:

Documentation of the objects you can use in Shopify Scripts: https://help.shopify.com/api/tutorials/shopify-scripts#cartdiscount-shipping

Good Examples you can use or check out: https://github.com/Shopify/scripts-public/tree/master/examples

Scripts youll find in this repo: 

1. own_discount.rb: (Line Items)

This script uses a cupon code which is set to 0% discount so it wont affect the products price. It is only used as a trigger for you to apply the discount you need. If you want to use bulk discounts you can use the term include, else you can use a "==" comparative for exact cupon names. In the case of this code, it discounts 1 product of a certain product_vendor. Thought this can be changed to fit any needs using the products: tags, product_type or vendor. Or any other information from the lineitem or variant. Also worth noticing this code discounts 1 product to the highest priced product in the cart. 

2. show_cupon.rb (Line Items)

This script uses two case senarios to detect if a cart has the necesary items for the cupon to apply. Here you can add more complex logic to the cupons requirements to be acepted. What I did here was use two functions to decide wether or not a cupon would be acepted. If its acepted, the cupon will show on the products as a property of one of them, a message if you will for the client to add upon the checkout. Its up to the client if he uses ir or not. If requires are not met, and the user tries to add the cupone then the cupon gets rejected and shows a message of why it was regected.

3. free_product_shipping.rb (Shipping)

This script can be used to do a cambpaing for a product you want to push more. You can offer free shipping to your clients if they add this product to their cart. This has to be added as a Shipping Script. It can be modified to offer free shipping if the cart has a specific vendor, if any product in the cart has a specific tag, on a min price on the cart accounting or not for  discounts and other. Its just a base. 

4. BXGXFREE

This script helps give out a Buy X Get X Free for buying a specific vendor, product type, products with tag or on a min cart price. Its really helpfull to set up campaings around brands or product types which you want to push on this type of discounts. 

MORE COMING SOON :D