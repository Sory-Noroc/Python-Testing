*** Settings ***
Library        DateTime
Library        SeleniumLibrary
Resource       ../common.resource

*** Variables ***
${URL}         https://demo.opencartmart.com/ordercoupon/index.php?route=account/register

${FIRST_NAME_LOCATOR}            id=input-firstname
${FIRST_NAME_ERROR_LOCATOR}      css=#account > div:nth-child(3) div.text-danger
${LAST_NAME_LOCATOR}             id=input-lastname
${LAST_NAME_ERROR_LOCATOR}       css=#account > div:nth-child(4) div.text-danger
${EMAIL_LOCATOR}                 id=input-email
${PHONE_NUMBER_LOCATOR}          id=input-telephone
${PHONE_ERROR_LOCATOR}           css=#account > div:nth-child(6) > div > div
${PASSWORD_LOCATOR}              id=input-password
${PASSWORD_ERROR_LOCATOR}        css=#content > form > fieldset:nth-child(2) > div.form-group.required.has-error div.text-danger
${CONFIRM_PASSWORD_LOCATOR}      id=input-confirm
${CONFIRM_PASS_ERROR_LOCATOR}    css=#content > form > fieldset:nth-child(2) > div.form-group.required.has-error div.text-danger
${SUBSCRIPTION_NAME}             newsletter
${PRIVACY_LOCATOR}               css=#content > form div > input[type=checkbox]
${REGISTER_BUTTON}               css=#content > form div > input[type=submit]
${STATUS_FIELD}                  css=#account-register > div.alert.alert-danger.alert-dismissible

*** Keywords ***
Populate Registration Fields
    [Arguments]     ${FIRST_NAME}    ${LAST_NAME}    ${EMAIL}    ${PHONE_NUM}    ${PASSWORD}    ${PASSWORD_CONFIRMATION}    ${IS_SUBSCRIBING}

    Input Text             ${FIRST_NAME_LOCATOR}           ${FIRST_NAME}
    Input Text             ${LAST_NAME_LOCATOR}            ${LAST_NAME}
    Input Text             ${EMAIL_LOCATOR}                ${EMAIL}
    Input Text             ${PHONE_NUMBER_LOCATOR}         ${PHONE_NUM}
    Input Password         ${PASSWORD_LOCATOR}             ${PASSWORD}
    Input Password         ${CONFIRM_PASSWORD_LOCATOR}     ${PASSWORD_CONFIRMATION}
    Select Radio Button    ${SUBSCRIPTION_NAME}            ${IS_SUBSCRIBING}

Validating Account has Been Created
    Element Should Not Be Visible   ${STATUS_FIELD}  # The error field
    Title Should Be                 Your Account Has Been Created!
    Current Frame Should Contain    Your Account Has Been Created!
    Current Frame Should Contain    Congratulations! Your new account has been successfully created!
