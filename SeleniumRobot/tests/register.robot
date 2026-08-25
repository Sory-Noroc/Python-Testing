*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/pages/register_page.resource

*** Variables ***
${URL}         https://demo.opencartmart.com/ordercoupon/index.php?route=account/register
${BROWSER}     chrome

*** Test Cases ***
Successful Registration Test
    Open Browser           ${URL}   ${BROWSER}
    Maximize browser window
    Title Should Be        Register Account
    Wait Until Element Is Visible    ${FIRST_NAME_LOCATOR}     timeout=4s
    
    Input Text             ${FIRST_NAME_LOCATOR}           Cristiano
    Input Text             ${LAST_NAME_LOCATOR}            Ronaldo
    Input Text             ${EMAIL_LOCATOR}                cristianoronaldo@gmail.com
    Input Text             ${PHONE_NUMBER_LOCATOR}         0730781841
    Input Password         ${PASSWORD_LOCATOR}             goodpass
    Input Password         ${CONFIRM_PASSWORD_LOCATOR}     goodpass
    Select Radio Button    ${SUBSCRIPTION_NAME}            1
    Select Checkbox        ${PRIVACY_LOCATOR}
    Click Button           ${REGISTER_BUTTON}

    Title Should Be                 Your Account Has Been Created!
    Current Frame Should Contain    Your Account Has Been Created!
    Current Frame Should Contain    Congratulations! Your new account has been successfully created!
#    Element Should Be Visible       CONTINUE_BUTTON

    [Teardown]    Close Browser