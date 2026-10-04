*** Settings ***
Resource           ../../../resources/features/currency_exchange.resource
Test Setup         Start Browser And Access Url
Test Teardown      Close Browser

*** Test Cases ***
Entering A Decimal Amount In Any Currency Field Updates All Other Currencies
    [Tags]    TC_InputValues_001    positive    smoke
    [Documentation]    When even a single digit is pressed into the currency field,
    ...                the other currencies automatically calculate the new exchanged value.

    FOR    ${currency}    IN    @{DEFAULT_CURRENCIES}
        Given The User Clears the Input Field for         ${currency}
        When The User Enters Into Input Field             ${currency}    123.99
        Then All Currency Fields Are Different Than Zero
    END

Invalid Characters Are Filtered Out Of Currency Fields
    [Tags]    negative    TC_InputValues_002    TC_InputValues_003    TC_InputValues_004
    [Documentation]    The input fields should ignore invalid characters like '-' and letters,
    ...                and only one dot is allowed for decimal separation.

    [Template]    The User Enters Invalid Data Into Field
    # currency              data                 expected
      mdl                   abc123abc            123
      eur                   -123.99              123.99
      usd                   123.56.78            123.56

Entering A Decimal Amount In The Extended Currencies Menu Updates All Other Currencies
    [Tags]    TC_InputValues_005    positive
    [Documentation]    When the 'Convertor valutar' button is clicked, more 
    ...                currencies appear, and they should update on any value being changed.

    Given The User Pressed the Currency Dropdown Arrow
    FOR    ${currency}    IN    @{EXTENDED_CURRENCIES}
        Given The User Clears the Input Field for         ${currency}
        When The User Enters Into Input Field             ${currency}    123.99
        Then All Currency Fields Are Different Than Zero
    END

Banks are Shown Correctly
    [Tags]    TC_Values_001
    [Documentation]    The User can choose a specific bank for precise exchange rates,
    ...                these banks have to be shown by default with minimal latency.
    Given The User Pressed The Currency Dropdown Arrow
    And The User Pressed The Bank Dropdown Arrow
    Then The Expected Banks are Visible

Changing the Bank Updates the Currencies
    [Tags]    TC_Bank_001    positive
    [Documentation]    When choosing a specific bank for the exchange, 
    ...                the rates might change compared to BNM.
    ...                The bank used for testing is 'Energbank'.

    Given The User Pressed The Currency Dropdown Arrow
    And The User Pressed The Bank Dropdown Arrow
    When The User Picked Bank                    ${BANKS}[1]
    Then All Currency Fields Are Different Than Zero
