*** Settings ***
Resource        ../resources/pages/login_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser


*** Test Cases ***
Successful Login with Default Account
    Click Button    ${LOGIN_BUTTON_LOCATOR}
    I Should Be Logged In


Successful Login while Registering Account
    ${unique_email}=           Create Email Using Timestamp
    Register Account Via UI    ${unique_email}    testpass123

    Input Text                 ${EMAIL_LOCATOR}            ${unique_email}
    Input Password             ${PASSWORD_LOCATOR}         testpass123
    Click Button               ${LOGIN_BUTTON_LOCATOR}

    I Should Be Logged In


Failing Login with Wrong Password