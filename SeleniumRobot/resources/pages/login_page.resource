*** Settings ***
Library        DateTime
Library        SeleniumLibrary
Resource       ../common.resource
Resource       register_page.resource

*** Variables ***
${URL}         https://demo.opencartmart.com/ordercoupon/index.php?route=account/login

${EMAIL_LOCATOR}                id=input-email
${PASSWORD_LOCATOR}             id=input-password
${LOGIN_BUTTON_LOCATOR}         css=#content > div > div:nth-child(2) > div > form > input

${MY_ACCOUNT_TITLE}             css=#content > h2:nth-child(1)

*** Keywords ***
I should be Logged In
    Page Should Not Contain Element    ${EMAIL_LOCATOR}
    Page Should Not Contain Element    ${PASSWORD_LOCATOR}
    Page Should Not Contain Element    ${LOGIN_BUTTON_LOCATOR}
    Element Should Contain      ${MY_ACCOUNT_TITLE}    My Account
    Title Should Be    My Account

Register Account via UI
    [Arguments]    ${email}    ${password}
    Go To     https://demo.opencartmart.com/ordercoupon/index.php?route=account/register
    Populate Registration Fields    Mike    Tyson    ${email}    0349734397    ${password}    ${password}    1
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}

    Page Should Contain No Field Errors
    Validating Account Has Been Created