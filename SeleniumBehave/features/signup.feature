Feature: Register an account
  Create an account and subscribe to newsletter
  Is linked to RegisterPage

    Scenario: Navigation from Home to Register page
      Given user accesses "Home" page
      When user clicks the "account_logo"
      And user clicks the "register_button"
      Then user is on "Register" page

    @adjustable
    Scenario: Registering an account is successful
      Given user accesses "Register" page
      When user enters "Test", "User", "testuser5@gmail.com", "077254352", "strong_password123", "strong_password123", 1, 1
      And user clicks the "continue_button"
      Then element "error_field" should be invisible
      And user is on "Register_Success" page

    Scenario Outline: Registering an account fails
      Given user accesses "Register" page
      When user enters "<firstname>", "<lastname>", "<email>", "<telephone>", "<password>", "<confirmed_pass>", <news>, <privacy>
      And user clicks the "continue_button"
      Then user should see the text "<error>"
      And user is on "Register" page
    
      Examples:
      | firstname         | lastname          | email               | telephone         | password          | confirmed_pass          | news          | privacy         | error                                          |
      | sorin             | noroc             | sorin@gmail.com     | 079135586         | pass              | differentPass           | 1             | 1               | Password confirmation does not match password! |
      | sorin             | noroc             | sorin@gmail.com     | 079135586         | goodPass          | goodPass                | 1             | 0               | Warning: You must agree to the Privacy Policy! |