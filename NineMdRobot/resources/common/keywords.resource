*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Click with Scroll and Wait
    [Arguments]    ${locator}
    Log    Element with locator ${locator} is searched.
    Scroll Element Into View         ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element                    ${locator}

Clear Input Field
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Press Keys                       ${locator}     CTRL+a+BACKSPACE