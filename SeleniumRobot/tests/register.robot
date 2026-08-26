*** Settings ***
Resource        ../resources/pages/register_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser

*** Test Cases ***
Successful Registration with Usual Data
    [Tags]    register     smoke     critical
    ${unique_email}=     Create Email using Timestamp

    Populate Registration Fields    first_name=Mihai
    ...    last_name=Viteazul
    ...    email=${unique_email}
    ...    phone_num=079135586
    ...    password=mihai0299!
    ...    password_confirmation=mihai0299!
    ...    is_subscribing=1
    Select Checkbox               ${PRIVACY_LOCATOR}
    Click Button                  ${REGISTER_BUTTON}
    Page Should Contain No Field Errors
    Validating Account Has Been Created


Successful Registration with Maximum Length of Field Data
    [Tags]    register
    ${unique_email}=     Create Email Using Timestamp

    Populate Registration Fields    
    ...    first_name=MyVeryLongFirstNameWithManyWords
    ...    last_name=MyVeryLongLastNameWithManyWordss
    ...    email=${unique_email}
    ...    phone_num=01234567890123456789012345678932
    ...    password=MyVeryLongPassword20
    ...    password_confirmation=MyVeryLongPassword20
    ...    is_subscribing=1
    Select Checkbox                   ${PRIVACY_LOCATOR}
    Click Button                      ${REGISTER_BUTTON}
    Page Should Contain No Field Errors
    Validating Account Has Been Created


Successful Registration with Minimum Length of Field Data
    [Tags]    register
    ${unique_email}=     Create Email Using Timestamp

    Populate Registration Fields
    ...    first_name=f
    ...    last_name=l
    ...    email=${unique_email}
    ...    phone_num=111
    ...    password=pass
    ...    password_confirmation=pass
    ...    is_subscribing=1

    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}
    Page Should Contain No Field Errors
    Validating Account Has Been Created


Failed Registration due to Fields too Big
    [Documentation]    
    [Tags]    register    bug
    Populate Registration Fields
    ...    first_name=MyVeryLongFirstNameWithManyWords0
    ...    last_name=MyVeryLongLastNameWithManyWordss0
    ...    email=testgmail@gmail.com
    ...    phone_num=012345678901234567890123456789320
    ...    password=MyVeryLongPassword200
    ...    password_confirmation=MyVeryLongPassword200
    ...    is_subscribing=1

    Select Checkbox                   ${PRIVACY_LOCATOR}
    Click Button                      ${REGISTER_BUTTON}

    Scroll Element Into View          ${REGISTER_BUTTON}
    Element Should Contain        ${FIRST_NAME_ERROR_LOCATOR}    First Name must be between 1 and 32 characters!
    Element Should Contain        ${LAST_NAME_ERROR_LOCATOR}     Last Name must be between 1 and 32 characters!
    Element Should Contain        ${PHONE_ERROR_LOCATOR}         Telephone must be between 3 and 32 characters!
    Element Should Contain        ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!


Failed Registration with Password too Big
    [Tags]    register    bug
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword200
    ...    password_confirmation=MyVeryLongPassword200
    ...    is_subscribing=1

    Select Checkbox                   ${PRIVACY_LOCATOR}
    Click Button                      ${REGISTER_BUTTON}

    Element Should Contain            ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!
    Title Should Be                   Register Account


Failed Registration due to Policy not Accepted
    [Tags]    register
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword
    ...    password_confirmation=MyVeryLongPassword
    ...    is_subscribing=1

    Click Button                     ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!


Failed Registration due to Wrong Password Confirmation
    [Tags]    register
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword
    ...    password_confirmation=DifferentPassword
    ...    is_subscribing=1

    Select Checkbox           ${PRIVACY_LOCATOR}
    Click Button              ${REGISTER_BUTTON}

    Element Should Contain    ${CONFIRM_PASS_ERROR_LOCATOR}    Password confirmation does not match password!


Failed Registration when no Fields are Populated
    [Tags]    register
    Click Button                     ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!

    Element Should Contain        ${FIRST_NAME_ERROR_LOCATOR}    First Name must be between 1 and 32 characters!
    Element Should Contain        ${LAST_NAME_ERROR_LOCATOR}     Last Name must be between 1 and 32 characters!
    Element Should Contain        ${PHONE_ERROR_LOCATOR}         Telephone must be between 3 and 32 characters!
    Element Should Contain        ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!
