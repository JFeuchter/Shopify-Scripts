ReadMe

Here Ill be posting Shopify Scripts to help the comunity. If you have any questions about the scripts Ill be keeping tabs on the Issues. Any suggestions to better the code is more then welcome! :D 

Here Ill leave a few interesting links you might need:

Documentation of the objects you can use in Shopify Scripts: https://help.shopify.com/api/tutorials/shopify-scripts#cartdiscount-shipping

Good Examples you can use or check out: https://github.com/Shopify/scripts-public/tree/master/examples

Scripts youll find in this repo: 

1. own_discount.rb: 

This script uses a cupon code which is set to 0% discount so it wont affect the products price. It is only used as a trigger for you to apply the discount you need. If you want to use bulk discounts you can use the term include, else you can use a "==" comparative for exact cupon names. In the case of this code, it discounts 1 product of a certain product_vendor. Thought this can be changed to fit any needs using the products: tags, product_type or vendor. Or any other information from the lineitem or variant. Also worth noticing this code discounts 1 product to the highest priced product in the cart. 


MORE COMING SOON :D