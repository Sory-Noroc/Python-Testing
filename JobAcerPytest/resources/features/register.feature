Feature: Account Registration
  A new user can create an account using their first name, last name, username,
  email and password.

  @collision
  Scenario: Happy path for user registration
    Given user is on the "register" page
    When user registers with "Tom", "Sawyer", "sorinnoroc@gmail.com", "Sory02", "testpass123" and "testpass123"
    And user clicks "Create Account"
    Then verify user is on the "home" page
