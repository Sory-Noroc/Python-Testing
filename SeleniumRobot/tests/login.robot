*** Settings ***
Resource        ../resources/pages/login_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser


*** Test Cases ***
Successful Login with Default Account
    [Tags]    login    smoke
    Click Button                       ${LOGIN_BUTTON_LOCATOR}
    Page Should Not Contain Element    ${LOGIN_ERROR}
    I Should Be Logged In


Failing Login with Correct Email but Wrong Password
    [Tags]    login
    Populate Login Fields        demo@opencartmart.com        wrong_password123
    Click Button                 ${LOGIN_BUTTON_LOCATOR}
    Login Fails with Generic Error


Failing Login with Incorrect Credentials
    [Tags]    login
    Populate Login Fields        randomemail@gmail.com        random_pass123
    Click Button                 ${LOGIN_BUTTON_LOCATOR}
    Login Fails with Generic Error


Failing Login for Admin Account Injection Attempt
    [Tags]    login
    Populate Login Fields        admin    password' or 1=1;--
    Click Button                 ${LOGIN_BUTTON_LOCATOR}
    Login Fails with Generic Error
