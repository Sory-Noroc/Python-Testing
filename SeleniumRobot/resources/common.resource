*** Variables ***
${BROWSER}     chrome

*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Initialize and maximize browser session
    [Arguments]    ${URL}

    Open Browser           ${URL}    ${BROWSER}
    Maximize browser window
