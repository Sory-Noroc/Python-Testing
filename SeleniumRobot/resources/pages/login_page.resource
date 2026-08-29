*** Settings ***
Library        DateTime
Library        SeleniumLibrary
Resource       ../common.resource

*** Variables ***
${URL}                 https://demo.opencartmart.com/ordercoupon/index.php?route=account/login
${LOGIN_PAGE_TITLE}    Account Login

${EMAIL_LOCATOR}                id=input-email
${PASSWORD_LOCATOR}             id=input-password
${LOGIN_BUTTON_LOCATOR}         css=#content > div > div:nth-child(2) > div > form > input
${LOGIN_ERROR}                  css=#account-login > div.alert.alert-danger.alert-dismissible

${MY_ACCOUNT_TITLE}             css=#content > h2:nth-child(1)

*** Keywords ***
Populate Login Fields
    [Arguments]    ${email}    ${password}
    Input Text            ${EMAIL_LOCATOR}            ${email}
    Input Password        ${PASSWORD_LOCATOR}         ${password}
    

I should be Logged In
    Page Should Not Contain Element    ${EMAIL_LOCATOR}
    Page Should Not Contain Element    ${PASSWORD_LOCATOR}
    Page Should Not Contain Element    ${LOGIN_BUTTON_LOCATOR}
    Element Should Contain             ${MY_ACCOUNT_TITLE}    My Account
    Title Should Be                    My Account

Login Fails with Generic Error
    Wait Until Element Is Visible    ${LOGIN_ERROR}               timeout=2s
    Element Should Contain           ${LOGIN_ERROR}               Warning: No match for E-Mail Address and/or Password.
    Title Should Be                  ${LOGIN_PAGE_TITLE}
