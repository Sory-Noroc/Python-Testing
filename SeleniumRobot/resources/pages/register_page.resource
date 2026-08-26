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
Create Email using Timestamp
    ${timestamp}=        Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_email}=     Set Variable        user_${timestamp}@example.com
    RETURN    ${unique_email}

Populate Registration Fields
    [Arguments]     ${first_name}    ${last_name}    ${email}    ${phone_num}    ${password}    ${password_confirmation}    ${is_subscribing}

    Input Text             ${FIRST_NAME_LOCATOR}           ${first_name}
    Input Text             ${LAST_NAME_LOCATOR}            ${last_name}
    Input Text             ${EMAIL_LOCATOR}                ${email}
    Input Text             ${PHONE_NUMBER_LOCATOR}         ${phone_num}
    Input Password         ${PASSWORD_LOCATOR}             ${password}
    Input Password         ${CONFIRM_PASSWORD_LOCATOR}     ${password_confirmation}
    Select Radio Button    ${SUBSCRIPTION_NAME}            ${is_subscribing}

Validating Account has Been Created
    Element Should Not Be Visible   ${STATUS_FIELD}  # The error field
    Title Should Be                 Your Account Has Been Created!
    Current Frame Should Contain    Your Account Has Been Created!
    Current Frame Should Contain    Congratulations! Your new account has been successfully created!

Page Should Contain No Field Errors
    Page Should Not Contain Element        ${FIRST_NAME_ERROR_LOCATOR}
    Page Should Not Contain Element        ${LAST_NAME_ERROR_LOCATOR}
    Page Should Not Contain Element        ${PHONE_ERROR_LOCATOR}
    Page Should Not Contain Element        ${PASSWORD_ERROR_LOCATOR}
