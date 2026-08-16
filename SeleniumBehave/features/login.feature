Feature: Login to account
  In order to use the app functionalities we need to log in.
  Is linked to LoginPage

  Scenario: navigation from home page to login page
    Given user accesses "Home" page
    When user clicks the "account_logo"
    And user clicks the "login_button"
    Then user is on "Login" page

  Scenario: login with correct credentials works
    Given user accesses "Login" page
    When user enters username "sorinnoroc1@gmail.com" and password "sorin.noroc"
    And user clicks the "login_button"
    Then user is on "Account" page

  @flaky
  Scenario: login with random credentials fails
    Given user accesses "Login" page
    When user enters random username and password
    And user clicks the "login_button"
    Then user should see the error "Warning: No match for E-Mail Address and/or Password."

  @slow
  @adjustable
  Scenario Outline: failed login with invalid data
    Testing wrong input field data, as well as injection attacks

    Given user accesses "Login" page
    When user enters username "<username>" and password "<password>"
    And user clicks the "login_button"
    Then user should see the error "Warning: No match for E-Mail Address and/or Password."

    Examples:
      | username              | password                  |
      | neexistent            | anypass                   |
      | sorinnoroc3@gmail.com |                           |
      |                       | good_password             |
      | short                 | good_password             |
      |                       |                           |
      | sorinnoroc3@gmail.com | password' or 1=1;--       |
