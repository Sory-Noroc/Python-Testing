*** Settings ***
Library    String
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

Get Formatted Locator
    [Arguments]    ${formattable_locator}    ${placeholder}
    ${formatted_locator}=    Format String           ${formattable_locator}    placeholder=${placeholder}
    RETURN    ${formatted_locator}