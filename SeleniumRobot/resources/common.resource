*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}     chrome

*** Keywords ***
Setup Browser
    [Arguments]    ${URL}

    Open Browser           ${URL}    ${BROWSER}
    Maximize browser window
