Feature: Account Registration
  A new user can create an account using their first name, last name, username, email and password.

    @JA_Register_001  @local  @positive
    Scenario: Happy path for user registration
      Given user "Sory02" is NOT present in the database
      And user is on the "register" page
      When user registers with "Tom", "Sawyer", "sorinnoroc@gmail.com", "Sory02", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then user is on the code verification page


    @JA_Register_003  @negative
    Scenario: Registration fails with empty fields
      Given user is on the "register" page
      When user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page


    @JA_Register_004 @JA_Register_005 @JA_Register_006 @JA_Register_007  @negative
    Scenario Outline: Registration fails with invalid data
      Given user "Sory02" is NOT present in the database
      And user is on the "register" page
      When user registers with "<first_name>", "<last_name>", "<email>", "<username>", "<password>" and "<password_confirmation>"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page
      And user should see the error "<error>"

      Examples: Bad Credentials
      | id | first_name | last_name | email                 | username | password     | password_confirmation | error |
      | 4  | Tom        | Sawyer    | sorinnoroc@gmail.com  | Sory02   | pass123      | pass123               | Password must be at least 10 characters long |
      | 5  | Tom        | Sawyer    | sorinnoroc@gmail.com  | So       | testpass123  | testpass123           | Username must be between 3 and 20 characters |
      | 6  | Tom        | Sawyer    | sorinnoroc@gmail.com  | testnametestnametest1   | password123 | password123 | Username must be between 3 and 20 characters |
      | 7  | Tom        | Sawyer    | sorinnoroc@gmail.com  | Sory02   | testpass123  | differentpass123      | Passwords do not match! |


    @JA_Register_008 @negative
    Scenario: Registration fails with invalid email format
      Given user "Sory02" is NOT present in the database
      And user is on the "register" page
      When user registers with "Tom", "Sawyer", "sorinnoroc.gmail.com", "Sory02", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page

    @JA_Register_010 @JA_Register_011  @negative
    Scenario Outline: Registration fails because user is already registered on the platform
      Given user "testuser" is already registered
      And user is on the "register" page
      When user registers with "<first_name>", "<last_name>", "<email>", "<username>", "<password>" and "<password_confirmation>"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page
      And user should see the error "<error>"

    Examples: Bad Credentials
      | id | first_name | last_name | email                 | username | password     | password_confirmation | error |
      | 10 | Tom        | Sawyer    | testuser123@gmail.com | newusr   | password123  | password123           | Email already exists |
      | 11 | Tom        | Sawyer    | otheremail@gmail.com  | testuser | password123  | password123           | Username already exists |


    @JA_Register_012 @JA_Register_013 @negative
    Scenario Outline: Registration fails because admin user is already present in the database
      Given user is on the "register" page
      When user registers with "<first_name>", "<last_name>", "<email>", "<username>", "<password>" and "<password_confirmation>"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page
      And user should see the error "<error>"

    Examples:
      Examples: Bad Credentials
      | id | first_name | last_name | email                   | username          | password     | password_confirmation | error |
      | 12 | Tom        | Sawyer    | pytechie02@gmail.com    | differentusername | testpass123  | testpass123           | Email already exists    |
      | 13 | Tom        | Sawyer    | testgmail123@gmail.com  | admin             | testpass123  | testpass123           | Username already exists |


    @JA_Register_014 @negative
    Scenario: Registration fails with XSS vulnerable characters
      Given user "Sory02&" is NOT present in the database
      And user is on the "register" page
      When user registers with "Tom>", "Sawyer>", "testmail123@gmail.com", "Sory02&", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user is not on the code verification page
