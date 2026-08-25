*** Settings ***
Library        SeleniumLibrary
Resource       ../common.resource

*** Variables ***
${URL}         https://demo.opencartmart.com/ordercoupon/index.php?route=account/register

${FIRST_NAME_LOCATOR}        id=input-firstname
${LAST_NAME_LOCATOR}         id=input-lastname
${EMAIL_LOCATOR}             id=input-email
${PHONE_NUMBER_LOCATOR}      id=input-telephone
${PASSWORD_LOCATOR}          id=input-password
${CONFIRM_PASSWORD_LOCATOR}  id=input-confirm
${SUBSCRIPTION_NAME}         newsletter
${PRIVACY_LOCATOR}           css=#content > form div > input[type=checkbox]
${REGISTER_BUTTON}           css=#content > form div > input[type=submit]
${STATUS_FIELD}              css=#account-register > div.alert.alert-danger.alert-dismissible

*** Keywords ***
Initialize Browser And Wait For Page To Be Loaded
    Initialize And Maximize Browser Session    ${URL}
    Title Should Be                            Register Account
    Wait Until Element Is Visible              ${FIRST_NAME_LOCATOR}     timeout=2s

Populate Registration Fields
    [Arguments]     ${FIRST_NAME}    ${LAST_NAME}    ${EMAIL}    ${PHONE_NUM}    ${PASSWORD}    ${PASSWORD_CONFIRMATION}    ${IS_SUBSCRIBING}

    Input Text             ${FIRST_NAME_LOCATOR}           ${FIRST_NAME}
    Input Text             ${LAST_NAME_LOCATOR}            ${LAST_NAME}
    Input Text             ${EMAIL_LOCATOR}                ${EMAIL}
    Input Text             ${PHONE_NUMBER_LOCATOR}         ${PHONE_NUM}
    Input Password         ${PASSWORD_LOCATOR}             ${PASSWORD}
    Input Password         ${CONFIRM_PASSWORD_LOCATOR}     ${PASSWORD_CONFIRMATION}
    Select Radio Button    ${SUBSCRIPTION_NAME}            ${IS_SUBSCRIBING}

Test Registration Flow for Specific Data
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}    ${PHONE_NUM}    ${PASS}    ${PASS_CONFIRM}    ${IS_SUBSCRIBING}

    ${TIMESTAMP}=        Get Current Date    result_format=%Y%m%d%H%M%S
    ${UNIQUE_EMAIL}=     Set Variable        user_${TIMESTAMP}@example.com

    Initialize Browser And Wait For Page To Be Loaded
    Populate Registration Fields    ${FIRST_NAME}    ${LAST_NAME}    ${UNIQUE_EMAIL}    ${PHONE_NUM}    ${PASS}    ${PASS_CONFIRM}    ${IS_SUBSCRIBING}
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}

    Element Should Not Be Visible   ${STATUS_FIELD}  # The error field
    Title Should Be                 Your Account Has Been Created!
    Current Frame Should Contain    Your Account Has Been Created!
    Current Frame Should Contain    Congratulations! Your new account has been successfully created!

    [Teardown]    Close Browser
