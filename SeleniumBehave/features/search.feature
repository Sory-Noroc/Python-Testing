Feature: Searching for products
  Using the 'Search' input and button, the user can type the name of the wanted product
  and search it on the platform

  Background: the user has to be logged in
    Given user accesses "Login" page
    When user enters username "sorinnoroc1@gmail.com" and password "sorin.noroc"
    And user clicks the "login_button"
    Then user is on "Account" page

  Scenario: user searches for "mac" product and clicks the "search_button"
    Given user accesses "Home" page
    When user enters "mac" in search bar
    And user clicks the "search_button"
    Then user should see product "iMac"
    And user should see product "MacBook"
    And user should see product "MacBook Air"
    And user should see product "MacBook Pro"

  Scenario: user searches for "mac" product and clicks the "Enter" key
    Given user accesses "Home" page
    When user enters "mac" + Enter in search bar
    Then user should see product "iMac"
    And user should see product "MacBook"
    And user should see product "MacBook Air"
    And user should see product "MacBook Pro"

  Scenario: user searches for "samsung" product and clicks the "Enter" key
    Given user accesses "Home" page
    When user enters "samsung" + Enter in search bar
    Then user should see product "Samsung SyncMaster 941BW"
    And user should see product "Samsung Galaxy Tab 10.1"

  Scenario: user searches for invalid product and clicks the "Enter" key
    Given user accesses "Home" page
    When user enters "inexistent product" + Enter in search bar
    Then user should see product "There is no product that matches the search criteria."