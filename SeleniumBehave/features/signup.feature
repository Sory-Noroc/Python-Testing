Feature: Login to account
  In order to use the app functionalities we need to log in

  Scenario: successful login with valid data
    Given the user is on the login page 'https://www.saucedemo.com/'
    When user enters login details
    | field          | value                        |
    | username_field | standard_user                |
    | password_field | secret_sauce                 |
    And user clicks the Login button
    Then user should login successfully

  Scenario: failed login with invalid password
    Given the user is on the login page 'https://www.saucedemo.com/'
    When user enters login details
    | field          | value                        |
    | username_field | standard_user                |
    | password_field | wrong_password               |
    Then user should not login successfully
