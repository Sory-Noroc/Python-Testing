*** Settings ***
Resource    ../common.resource
Library     Collections
Library     String


*** Variables ***
${URL}                             https://demo.opencartmart.com/ordercoupon/index.php?route=common/home

${SEARCH_INPUT_LOCATOR}            css=#search input[type="text"]
${SEARCH_BUTTON_LOCATOR}           css=#search button[type="button"]

${SEARCH_RESULTS_TITLE}            css=#content > h1
${PRODUCT_CARDS}                   css=#content div.product-layout
${PRODUCT_TITLES}                  css=.product-layout .caption h4 a
${NO_RESULTS_MESSAGE}              css=#content p:nth-child(7)


*** Keywords ***
Search For Product and Hit Enter
    [Arguments]                              ${product_name}
    Input Text                               ${SEARCH_INPUT_LOCATOR}                ${product_name}
    Press Keys                               ${SEARCH_INPUT_LOCATOR}                RETURN

Search For Product and Click Enter Button
    [Arguments]                              ${product_name}
    Input Text                               ${SEARCH_INPUT_LOCATOR}                ${product_name}
    Click Button                             ${SEARCH_BUTTON_LOCATOR}
    
Verify Search Result Count
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible            ${PRODUCT_CARDS}                       timeout=4s
    ${actual_count}=    Get Element Count    ${PRODUCT_CARDS}
    Should Be Equal As Integers              ${actual_count}                        ${expected_count}
    ...    msg=Expected ${expected_count} products, but found ${actual_count}.

Get Displayed Product Titles
    @{elements}=    Get WebElements          ${PRODUCT_TITLES}
    @{titles}=      Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text                 ${element}
        Append To List                       ${titles}    ${text}
    END
    RETURN                                   ${titles}

Verify Exact Product Titles
    [Arguments]                              @{expected_titles}
    @{actual_titles}=    Get Displayed Product Titles
    Lists Should Be Equal                    ${actual_titles}    ${expected_titles}    ignore_order=True

Verify No Products Found with Message
    [Arguments]    ${expected_message}
    Page Should Not Contain Element          ${PRODUCT_CARDS}
    Wait Until Element Is Visible            ${NO_RESULTS_MESSAGE}                  timeout=4s
    Element Should Contain                   ${NO_RESULTS_MESSAGE}                  ${expected_message}