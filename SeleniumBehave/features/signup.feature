Feature: Register an account
  Create an account and subscribe to newsletter
  Is linked to RegisterPage

    Scenario: Navigation from Home to Register page
      Given user accesses "Home" page
      When user clicks the "account_logo"
      And user clicks the "register_button"
      Then user is on "Register" page

    Scenario: Registering an account is successful
      Given user accesses "Register" page
      When user enters "Test", "User", "testuser@gmail.com", "077254352", "strong_password123", "strong_password123", 1, 1
      And user clicks the "continue_button"
      Then user is on "Register_Success" page