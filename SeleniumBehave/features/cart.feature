Feature: Add to Cart
  We can add to cart a product we want to buy later.
  The cart is shown on all pages, so any page can check the cart details(number of items and total cost).

  Scenario: user enters the home screen and adds the first product to cart
    Given user accesses "Home" page
    When user clicks the "first_add_to_cart_button"
    Then user should see cart status "1 item(s) - $602.00"

  Scenario: user adds multiple products to cart and cart cost updates
    Given user accesses "Home" page
    When user enters "mac" + Enter in search bar
    And user adds product "iMac" to cart
    And user adds product "MacBook Air" to cart
    Then user should see cart status "2 item(s) - $1,324.00"