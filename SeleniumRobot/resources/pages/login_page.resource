*** Settings ***
Library        DateTime
Library        SeleniumLibrary
Resource       ../common.resource

*** Variables ***
${URL}                 https://demo.opencartmart.com/ordercoupon/index.php?route=account/login
${LOGIN_PAGE_TITLE}    Account Login

${EMAIL_LOCATOR}                id=input-email
${PASSWORD_LOCATOR}             id=input-password
${LOGIN_BUTTON_LOCATOR}         css=input[type="submit"]
${LOGIN_ERROR}                  css=#account-login .alert-danger

${MY_ACCOUNT_TITLE}             css=#content > h2:nth-child(1)

*** Keywords ***
Populate Login Fields
    [Arguments]    ${email}    ${password}
    Input Text            ${EMAIL_LOCATOR}            ${email}
    Input Password        ${PASSWORD_LOCATOR}         ${password}


Submit Login Form
    Click Button    ${LOGIN_BUTTON_LOCATOR}


Verify Successful Login
    Wait Until Element Is Visible      ${MY_ACCOUNT_TITLE}        timeout=2s
    Page Should Not Contain Element    ${EMAIL_LOCATOR}
    Page Should Not Contain Element    ${PASSWORD_LOCATOR}
    Page Should Not Contain Element    ${LOGIN_BUTTON_LOCATOR}
    Element Should Contain             ${MY_ACCOUNT_TITLE}    My Account
    Title Should Be                    My Account


Verify Login Failure
    Wait Until Element Is Visible    ${LOGIN_ERROR}               timeout=2s
    Element Should Contain           ${LOGIN_ERROR}               Warning: No match for E-Mail Address and/or Password.
    Title Should Be                  ${LOGIN_PAGE_TITLE}
