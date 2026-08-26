*** Variables ***
${BROWSER}     chrome

*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Setup Browser
    [Arguments]    ${URL}

    Open Browser           ${URL}    ${BROWSER}
    Maximize browser window
