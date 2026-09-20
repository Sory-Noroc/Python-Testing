*** Settings ***
Resource        ../resources/pages/login_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser


*** Test Cases ***
Successful Login with Default Account
    [Tags]    login
    Submit Login Form
    Verify Successful Login
    
    
Successful Login with Valid Credentials
    [Tags]    login    smoke
    Populate Login Fields    demo@opencartmart.com    123456
    Submit Login Form
    Verify Successful Login

Invalid Login Scenarios
    [Tags]    login    negative
    [Template]    Verify Invalid Login
    # Email                      Password
    demo@opencartmart.com        wrong_pass123
    invalid_email@domain.com     random_pass123
    admin                        password' or 1=1;--


*** Keywords ***
Verify Invalid Login
    [Arguments]    ${email}    ${password}
    Populate Login Fields    ${email}    ${password}
    Submit Login Form
    Verify Login Failure