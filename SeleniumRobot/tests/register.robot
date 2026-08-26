*** Settings ***
Resource        ../resources/pages/register_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser

*** Test Cases ***
Successful Registration with Usual Data
    ${TIMESTAMP}=        Get Current Date    result_format=%Y%m%d%H%M%S
    ${UNIQUE_EMAIL}=     Set Variable        user_${TIMESTAMP}@example.com

    Populate Registration Fields    Mihai    Viteazul    ${UNIQUE_EMAIL}    079135586   mihai0299!    mihai0299!    1
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}
    Validating Account Has Been Created


Successful Registration with Maximum Length of Field Data
    ${TIMESTAMP}=        Get Current Date    result_format=%Y%m%d%H%M%S
    ${UNIQUE_EMAIL}=     Set Variable        user_${TIMESTAMP}@example.com

    Populate Registration Fields    MyVeryLongFirstNameWithManyWords    MyVeryLongLastNameWithManyWordss    ${UNIQUE_EMAIL}    01234567890123456789012345678932    MyVeryLongPassword20    MyVeryLongPassword20    1
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}
    Validating Account Has Been Created


Successful Registration with Minimum Length of Field Data
    ${TIMESTAMP}=        Get Current Date    result_format=%Y%m%d%H%M%S
    ${UNIQUE_EMAIL}=     Set Variable        user_${TIMESTAMP}@example.com

    Populate Registration Fields    f    l    ${UNIQUE_EMAIL}    111    pass    pass    1
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}
    Validating Account Has Been Created


Failed Registration due to Fields too Big
    Populate Registration Fields    MyVeryLongFirstNameWithManyWords0    MyVeryLongLastNameWithManyWordss0    testgmail@gmail.com    012345678901234567890123456789320    MyVeryLongPassword200    MyVeryLongPassword200    1
    Select Checkbox                   ${PRIVACY_LOCATOR}
    Click Button                      ${REGISTER_BUTTON}

    Scroll Element Into View          ${REGISTER_BUTTON}
    Element Should Contain        ${FIRST_NAME_ERROR_LOCATOR}    First Name must be between 1 and 32 characters!
    Element Should Contain        ${LAST_NAME_ERROR_LOCATOR}     Last Name must be between 1 and 32 characters!
    Element Should Contain        ${PHONE_ERROR_LOCATOR}         Telephone must be between 3 and 32 characters!
    Element Should Contain        ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!


Failed Registration with Password too Big
    Populate Registration Fields      MyFirstName    MyLastName    testgmail@gmail.com    03535266242    MyVeryLongPassword200    MyVeryLongPassword200    1
    Select Checkbox                   ${PRIVACY_LOCATOR}
    Click Button                      ${REGISTER_BUTTON}

    Element Should Contain            ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!
    Title Should Be                   Register Account


Failed Registration due to Policy not Accepted
    Populate Registration Fields     Cristiano    Ronaldo    testemail@gmail.com    0730781178    goodpass    goodpass    1
    Click Button                     ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!


Failed Registration due to Wrong Password Confirmation
    Populate Registration Fields    Cristiano    Ronaldo    testemail@gmail.com    0730781178    goodpass    differentpass    1
    Select Checkbox           ${PRIVACY_LOCATOR}
    Click Button              ${REGISTER_BUTTON}

    Element Should Contain    ${CONFIRM_PASS_ERROR_LOCATOR}    Password confirmation does not match password!


Failed registration when no fields are populated
    Click Button                     ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!

    Element Should Contain        ${FIRST_NAME_ERROR_LOCATOR}    First Name must be between 1 and 32 characters!
    Element Should Contain        ${LAST_NAME_ERROR_LOCATOR}     Last Name must be between 1 and 32 characters!
    Element Should Contain        ${PHONE_ERROR_LOCATOR}         Telephone must be between 3 and 32 characters!
    Element Should Contain        ${PASSWORD_ERROR_LOCATOR}      Password must be between 4 and 20 characters!
