Feature: Searching for products
  Using the 'Search' input and button, the user can type the name of the wanted product
  and search it on the platform

  Background: the user has to be logged in
    Given user accesses "Login" page
    When user enters username "sorinnoroc1@gmail.com" and password "sorin.noroc"
    And user clicks the "login_button"
    Then user is on "Account" page

  Scenario: user searches for specific product
    Given user accesses "Home" page
    When user enters "mac" in search bar
    And user clicks the "search_button"
    Then user should see "iMac" product
    And user should see "MacBook" product
    And user should see "MacBook Air" product
    And user should see "MacBook Pro" product

