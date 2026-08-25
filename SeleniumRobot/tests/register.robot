*** Settings ***
Library         DateTime
Resource        ../resources/pages/register_page.resource

*** Test Cases ***
Successful Registration with Usual Data
    Test Registration Flow For Specific Data    Mihai    Viteazul    079135586   mihai0299!    mihai0299!    1

Successful Registration with Maximum Length of Field Data
    Test Registration Flow For Specific Data    MyVeryLongFirstNameWithManyWords    MyVeryLongLastNameWithManyWordss    01234567890123456789012345678932    MyVeryLongPassword20    MyVeryLongPassword20    1

Successful Registration with Minimum Length of Field Data
    Test Registration Flow For Specific Data    f    l    111    pass    pass    1

Failed registration due to policy not accepted
    Initialize Browser And Wait For Page To Be Loaded
    Populate Registration Fields    Cristiano    Ronaldo    testemail@gmail.com    0730781178    goodpass    goodpass    1
    Click Button              ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!

    [Teardown]    Close Browser

Failed Registration due to wrong password confirmation
    Initialize Browser And Wait For Page To Be Loaded
    Populate Registration Fields    Cristiano    Ronaldo    testemail@gmail.com    0730781178    goodpass    differentpass    1
    Select Checkbox            ${PRIVACY_LOCATOR}
    Click Button               ${REGISTER_BUTTON}

    Page Should Contain    Password confirmation does not match password!
    [Teardown]    Close Browser
    
Failed registration when no fields are populated
    Initialize Browser And Wait For Page To Be Loaded
    Click Button               ${REGISTER_BUTTON}

    Wait Until Element Is Visible    ${STATUS_FIELD}
    Element Text Should Be           ${STATUS_FIELD}     Warning: You must agree to the Privacy Policy!

    Page Should Contain        First Name must be between 1 and 32 characters!
    Page Should Contain        Last Name must be between 1 and 32 characters!
    Page Should Contain        E-Mail Address does not appear to be valid!
    Page Should Contain        Telephone must be between 3 and 32 characters!
    Page Should Contain        Password must be between 4 and 20 characters!
