*** Settings ***
Resource           ../../../resources/features/currency_exchange.resource
Test Setup         Start Browser And Access Url
Test Teardown      Close Browser

*** Test Cases ***
Input Fields Accept Numbers
    [Tags]
    [Documentation]
    Select and Clear Input Field     mdl
    Type Into Input Field            mdl        123.9
    Verify All Currency Fields Are Different Than Zero

