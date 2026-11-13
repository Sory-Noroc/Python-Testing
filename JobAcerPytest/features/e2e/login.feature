# Created by sorin at 11/11/2026
Feature: Login
  The login feature ensures the user can access their account information and additional functionalities of the
  application. By accessing the /login endpoint the user can see the login page.

  @JA_Login_001
  Scenario: User login with email works
    Given user "Student" is already registered
    And user "Student" gets verified
    And user is on the "login" page
    When user enters "sorin.noroc@student.tuiasi.ro" and "sorin.noroc" into login fields
    And user clicks "Sign In" button
    Then verify user is on the "home" page
    And user "Student" is logged in
