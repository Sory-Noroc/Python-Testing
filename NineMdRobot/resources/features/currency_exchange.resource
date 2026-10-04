*** Settings ***
Library           String
Resource          ../common/setup.resource
Resource          ../common/keywords.resource


*** Variables ***
${URL}            ${BASE_URL}${ENDPOINTS.home}

${DROPDOWN_BUTTON}             xpath=//div[@data-onboarding='home-calculator']/button[//span[contains(text(), 'valuta')]]
${INPUT_FIELD}                 xpath=//input[@inputmode='numeric'][following-sibling::span[text()='{placeholder}']]
${ALL_VISIBLE_INPUT_FIELDS}    xpath=//div[@data-onboarding='home-calculator']//div[contains(@class, 'row')]//input[@inputmode='numeric']
${BANK_DROPDOWN_BUTTON}        xpath=//div[@data-onboarding='home-calculator']//button[contains(@class, 'bank')]
${ALL_VISIBLE_BANKS}           xpath=//div[@data-onboarding='home-calculator']//div[preceding-sibling::button[contains(@class, 'bank')]]//button
${BANK_CHOICE_BUTTON}          xpath=//div[@data-onboarding='home-calculator']//div[preceding-sibling::button[contains(@class, 'bank')]]//button[text()='{placeholder}']

*** Keywords ***

### CURRENCY
The User Pressed the Currency Dropdown Arrow
    [Arguments]    ${timeout}=1s
    Wait Until Keyword Succeeds    5x    ${timeout}    Click With Scroll And Wait    ${DROPDOWN_BUTTON}
    Element Should Be Visible            ${BANK_DROPDOWN_BUTTON}
    ${currencies_count}=    Get Element Count    ${ALL_VISIBLE_INPUT_FIELDS}
    ${expected_count}=      Get Length    ${EXTENDED_CURRENCIES}
    Should Be Equal         ${currencies_count}    ${expected_count}
    ...    msg=Expected to see ${expected_count} currencies, but saw ${currencies_count}.

The User Clears the Input Field for
    [Arguments]            ${currency}
    ${locator}=    Get Formatted Locator         ${INPUT_FIELD}    placeholder=${currency}
    Clear Input Field                            ${locator}
    Verify Field Text Is                         ${currency}    0

The User Enters Into Input Field
    [Arguments]            ${currency}           ${value}
    ${locator}=    Get Formatted Locator         ${INPUT_FIELD}    placeholder=${currency}
    Wait Until Element Is Visible                ${locator}
    Input Text             ${locator}            ${value}

The User Enters Invalid Data Into Field
    [Arguments]    ${currency}    ${data}    ${expected}
    The User Clears The Input Field For          ${currency}
    The User Enters Into Input Field             ${currency}    ${data}    ${expected}
    Verify Field Text Is                         ${currency}    ${expected}

### BANK
The User Pressed The Bank Dropdown Arrow
    [Arguments]    ${timeout}=1s
    Wait Until Keyword Succeeds    5x    ${timeout}    Click With Scroll And Wait    ${BANK_DROPDOWN_BUTTON}
    Element Should Be Visible                      ${BANK_DROPDOWN_BUTTON}
    ${currencies_count}=      Get Element Count    ${ALL_VISIBLE_BANKS}
    ${expected_count}=        Get Length           ${BANKS}
    Should Be Equal           ${currencies_count}       ${expected_count}
    ...    msg=Expected to see ${expected_count} banks, but saw ${currencies_count}.

The User Picked Bank
    [Arguments]    ${bank}
    ${locator}=    Get Formatted Locator    ${BANK_CHOICE_BUTTON}    ${bank}
    Click With Scroll And Wait              ${locator}
    Element Should Not Be Visible           ${locator}
    
The Expected Banks are Visible
    FOR    ${expected_bank}    IN    @{BANKS}
        ${bank_locator}=    Get Formatted Locator    ${BANK_CHOICE_BUTTON}    ${expected_bank}
        Wait Until Keyword Succeeds    5x    200ms    Element Should Be Visible    ${bank_locator}
    END

### VERIFICATION
Verify Field Text Is
    [Arguments]            ${currency}           ${expected}
    ${locator}=    Get Formatted Locator         ${INPUT_FIELD}    ${currency}
    Wait Until Keyword Succeeds    5x    200ms    Element Attribute Value Should Be    ${locator}    value    ${expected}
    ${output}=     Get Value         ${locator}
    Should Be Equal                  ${output}     ${expected}
    ...    msg=Input field value is '${output}', but was expected '${expected}'.

All Currency Fields Show Zero
    ${currency_fields}=    Get WebElements       ${ALL_VISIBLE_INPUT_FIELDS}
    FOR    ${locator}    IN    ${currency_fields}
        Wait Until Element Is Visible    ${locator}
        ${output}=    Get Value          ${locator}
        Log    Currency field value is: '${output}'.
        Should Be Equal    ${output}     0
        ...    msg=Input field value is '${output}', but was expected '0'.
    END

All Currency Fields Are Different than Zero
    ${currency_fields}=    Get WebElements       ${ALL_VISIBLE_INPUT_FIELDS}
    FOR    ${locator}    IN    ${currency_fields}
        Wait Until Element Is Visible    ${locator}
        ${output}=    Get Value          ${locator}
        Log    Currency field value is: '${output}'.
        Should Not Be Equal    ${output}     0
        ...    msg=Input field value is '${output}', but was expected '0'.
    END
