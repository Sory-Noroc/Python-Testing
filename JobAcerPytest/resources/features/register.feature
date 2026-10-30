Feature: Account Registration
  A new user can create an account using their first name, last name, username,
  email and password.

    @collision @positive
    Scenario: Happy path for user registration
      Given user is on the "register" page
      When user registers with "Tom", "Sawyer", "sorinnoroc@gmail.com", "Sory02", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "home" page

    @JA_Register_003 @negative
    Scenario: Registration fails with empty fields
      Given user is on the "register" page
      When user clicks "Create Account"
      Then verify user is on the "register" page

    @JA_Register_004 @negative
    Scenario Outline: Registration fails with invalid data
      Given user is on the "register" page
      When user registers with "<first_name>", "<last_name>", "<email>", "<username>", "<password>" and "<password_confirmation>"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user should see the error "<error>"

      Examples: Bad Credentials
      | first_name | last_name | email                 | username | password     | password_confirmation | error |
      | Tom        | Sawyer    | testmail@gmail.com    | Sory02   | pass123      | pass123               | Password must be at least 10 characters long |
      | Tom        | Sawyer    | testmail@gmail.com    | So       | password123  | password123           | Username must be between 3 and 20 characters |
