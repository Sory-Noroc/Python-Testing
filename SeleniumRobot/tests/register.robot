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
    Accept Privacy Policy
    Submit Registration Form

    Validating Page Contains No Field Errors
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
    Accept Privacy Policy
    Submit Registration Form

    Validating Page Contains No Field Errors
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

    Accept Privacy Policy
    Submit Registration Form

    Validating Page Contains No Field Errors
    Validating Account Has Been Created


Failed Registration due to Fields too Big
    [Documentation]
    [Tags]    register    negative    bug
    Populate Registration Fields
    ...    first_name=MyVeryLongFirstNameWithManyWords0
    ...    last_name=MyVeryLongLastNameWithManyWordss0
    ...    email=testgmail@gmail.com
    ...    phone_num=012345678901234567890123456789320
    ...    password=MyVeryLongPassword200
    ...    password_confirmation=MyVeryLongPassword200
    ...    is_subscribing=1

    Accept Privacy Policy
    Submit Registration Form

    Validating Page Contains All Field Errors


Failed Registration with Password too Big
    [Tags]    register    negative    bug
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword200
    ...    password_confirmation=MyVeryLongPassword200
    ...    is_subscribing=1

    Accept Privacy Policy
    Submit Registration Form

    Validating Page Shows Password Error


Failed Registration due to Policy not Accepted
    [Tags]    register    negative
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword
    ...    password_confirmation=MyVeryLongPassword
    ...    is_subscribing=1

    Submit Registration Form

    Validating Page Shows Policy Error


Failed Registration due to Wrong Password Confirmation
    [Tags]    register    negative
    Populate Registration Fields
    ...    first_name=MyFirstName
    ...    last_name=MyLastName
    ...    email=testgmail@gmail.com
    ...    phone_num=0354795832
    ...    password=MyVeryLongPassword
    ...    password_confirmation=DifferentPassword
    ...    is_subscribing=1

    Accept Privacy Policy
    Submit Registration Form

    Validating Page Shows Password Confirmation Error


Failed Registration when no Fields are Populated
    [Tags]    register    negative
    Submit Registration Form

    Validating Page Shows Policy Error
    Validating Page Contains All Field Errors
