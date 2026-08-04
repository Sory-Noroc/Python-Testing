Feature: Login to account
  In order to use the app functionalities we need to log in

  Scenario: navigation from home page to login page
    Given user accesses "Home" page
    When user clicks the "account_logo"
    And user clicks the "login_button"
    Then user is on "Login" page

  Scenario: login with correct credentials works
    Given user accesses "Login" page
    When user enters login details
    And user clicks the "login_button"
    Then user is on "Account" page

#  Scenario: failed login with invalid password
#    Given the user is on the login page
#    When user enters login details
#    | field          | value                        |
#    | username_field | standard_user                |
#    | password_field | wrong_password               |
#    Then user should not login successfully
