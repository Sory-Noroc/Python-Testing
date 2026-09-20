*** Settings ***
Library        DateTime
Library        SeleniumLibrary
Resource       ../common.resource


*** Variables ***
${URL}         https://demo.opencartmart.com/ordercoupon/index.php?route=account/register

${FIRST_NAME_LOCATOR}            id=input-firstname
${LAST_NAME_LOCATOR}             id=input-lastname
${EMAIL_LOCATOR}                 id=input-email
${PHONE_NUMBER_LOCATOR}          id=input-telephone
${PASSWORD_LOCATOR}              id=input-password
${CONFIRM_PASSWORD_LOCATOR}      id=input-confirm
${SUBSCRIPTION_NAME}             newsletter
${PRIVACY_LOCATOR}               css=input[type="checkbox"][name="agree"]
${REGISTER_BUTTON}               css=input[type="submit"][value="Continue"]

${FIRST_NAME_ERROR_LOCATOR}      xpath=//input[@id='input-firstname']/following-sibling::div[@class='text-danger']
${LAST_NAME_ERROR_LOCATOR}       xpath=//input[@id='input-lastname']/following-sibling::div[@class='text-danger']
${PHONE_ERROR_LOCATOR}           xpath=//input[@id='input-telephone']/following-sibling::div[@class='text-danger']
${PASSWORD_ERROR_LOCATOR}        xpath=//input[@id='input-password']/following-sibling::div[@class='text-danger']
${CONFIRM_PASS_ERROR_LOCATOR}    xpath=//input[@id='input-confirm']/following-sibling::div[@class='text-danger']
${STATUS_FIELD}                  css=#account-register div.alert-danger


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

Accept Privacy Policy
    Select Checkbox               ${PRIVACY_LOCATOR}

Submit Registration Form
    Click Button                  ${REGISTER_BUTTON}

Validating Page Shows Password Error
    Wait Until Element Is Visible     ${PASSWORD_ERROR_LOCATOR}
    Element Should Contain            ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!
    Title Should Be                   Register Account
    
Validating Page Shows Password Confirmation Error
    Wait Until Element Is Visible     ${CONFIRM_PASS_ERROR_LOCATOR}
    Element Should Contain            ${CONFIRM_PASS_ERROR_LOCATOR}    Password confirmation does not match password!
    Title Should Be                   Register Account

Validating Page Shows Policy Error
    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!
    Title Should Be                   Register Account

Validating Account has Been Created
    Element Should Not Be Visible   ${STATUS_FIELD}  # The error field
    Title Should Be                 Your Account Has Been Created!
    Current Frame Should Contain    Your Account Has Been Created!
    Current Frame Should Contain    Congratulations! Your new account has been successfully created!

Validating Page Contains No Field Errors
    Page Should Not Contain Element        ${FIRST_NAME_ERROR_LOCATOR}
    Page Should Not Contain Element        ${LAST_NAME_ERROR_LOCATOR}
    Page Should Not Contain Element        ${PHONE_ERROR_LOCATOR}
    Page Should Not Contain Element        ${PASSWORD_ERROR_LOCATOR}

Validating Page Contains all Field Errors
    Scroll Element Into View      ${REGISTER_BUTTON}
    Element Should Contain        ${FIRST_NAME_ERROR_LOCATOR}    First Name must be between 1 and 32 characters!
    Element Should Contain        ${LAST_NAME_ERROR_LOCATOR}     Last Name must be between 1 and 32 characters!
    Element Should Contain        ${PHONE_ERROR_LOCATOR}         Telephone must be between 3 and 32 characters!
    Element Should Contain        ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!