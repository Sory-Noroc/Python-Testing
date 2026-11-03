Feature: Account Registration
  A new user can create an account using their first name, last name, username,
  email and password.

    @JA_Register_001  @local  @positive
    Scenario: Happy path for user registration
      Given user is on the "register" page
      When user registers with "Tom", "Sawyer", "sorinnoroc@gmail.com", "Sory02", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "home" page

    @JA_Register_003  @negative
    Scenario: Registration fails with empty fields
      Given user is on the "register" page
      When user clicks "Create Account"
      Then verify user is on the "register" page

    @JA_Register_004  @JA_Register_005  @JA_Register_006  @JA_Register_007  @JA_Register_008  @JA_Register_009  @negative
    Scenario Outline: Registration fails with invalid data
      Given user is on the "register" page
      When user registers with "<first_name>", "<last_name>", "<email>", "<username>", "<password>" and "<password_confirmation>"
      And user clicks "Create Account"
      Then verify user is on the "register" page
      And user should see the error "<error>"

      Examples: Bad Credentials
      | id | first_name | last_name | email                 | username | password     | password_confirmation | error |
      | 4  | Tom        | Sawyer    | sorinnoroc@gmail.com  | Sory02   | pass123      | pass123               | Password must be at least 10 characters long |
      | 5  | Tom        | Sawyer    | sorinnoroc@gmail.com  | So       | testpass123  | testpass123           | Username must be between 3 and 20 characters |
      | 6  | Tom        | Sawyer    | sorinnoroc@gmail.com  | testnametestnametest1   | password123 | password123 | Username must be between 3 and 20 characters |
      | 7  | Tom        | Sawyer    | pytechie02@gmail.com  | newusr   | password123  | password123           | Email already exists |
      | 8  | Tom        | Sawyer    | sorinnoroc@gmail.com  | Sory02   | password123  | password123           | Username already exists |
      | 9  | Tom        | Sawyer    | sorinnoroc@gmail.com  | Sory02   | testpass123  | differentpass123      | Passwords do not match! |

    @JA_Register_010 @negative
    Scenario: Registration fails with invalid email format
      Given user is on the "register" page
      When user registers with "Tom", "Sawyer", "sorinnoroc.gmail.com", "Sory02", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "register" page

    @JA_Register_012 @negative
    Scenario: Registration fails with XSS vulnerable characters
      Given user is on the "register" page
      When user registers with "Tom>", "Sawyer>", "sorinnoroc@gmail.com", "Sory02&", "testpass123" and "testpass123"
      And user clicks "Create Account"
      Then verify user is on the "register" page
