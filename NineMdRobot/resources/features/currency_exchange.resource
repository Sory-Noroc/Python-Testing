*** Settings ***
Library           String
Resource          ../common/setup.resource
Resource          ../common/keywords.resource


*** Variables ***
${URL}            ${BASE_URL}${ENDPOINTS.home}

${INPUT_FIELD}                 xpath=//input[@inputmode='numeric'][following-sibling::span[text()='{currency}']]
${ALL_VISIBLE_INPUT_FIELDS}    xpath=//div[@data-onboarding='home-calculator']//div[contains(@class, 'row')]//input[@inputmode='numeric']

*** Keywords ***
Get Currency Input Field Locator
    [Arguments]    ${formattable_locator}    ${currency}
    ${formatted_locator}=    Format String           ${formattable_locator}    currency=${currency}
    RETURN    ${formatted_locator}

Select and Clear Input Field
    [Arguments]            ${currency}
    ${locator}=    Get Currency Input Field Locator    ${INPUT_FIELD}    currency=${currency}
    Clear Input Field                ${locator}
    Verify Field Text Is             ${currency}    0

Type Into Input Field
    [Arguments]            ${currency}           ${value}
    ${locator}=    Get Currency Input Field Locator    ${INPUT_FIELD}    currency=${currency}
    Wait Until Element Is Visible                ${locator}
    Input Text             ${locator}            ${value}
    Verify Field Text Is   ${currency}           ${value}

Verify Field Text Is
    [Arguments]            ${currency}           ${text}
    ${locator}=    Get Currency Input Field Locator    ${INPUT_FIELD}    ${currency}
    Wait Until Element Is Visible    ${locator}
    ${output}=    Get Value          ${locator}
    Should Be Equal    ${output}     ${text}
    ...    msg=Input field value is '${output}', but was expected '${text}'.

Verify All Currency Fields Show Zero
    ${currency_fields}=    Get WebElements       ${ALL_VISIBLE_INPUT_FIELDS}
    FOR    ${locator}    IN    ${currency_fields}
        Wait Until Element Is Visible    ${locator}
        ${output}=    Get Value          ${locator}
        Log    Currency field value is: '${output}'.
        Should Be Equal    ${output}     0
        ...    msg=Input field value is '${output}', but was expected '0'.
    END

Verify All Currency Fields Are Different than Zero
    ${currency_fields}=    Get WebElements       ${ALL_VISIBLE_INPUT_FIELDS}
    FOR    ${locator}    IN    ${currency_fields}
        Wait Until Element Is Visible    ${locator}
        ${output}=    Get Value          ${locator}
        Log    Currency field value is: '${output}'.
        Should Not Be Equal    ${output}     0
        ...    msg=Input field value is '${output}', but was expected '0'.
    END
