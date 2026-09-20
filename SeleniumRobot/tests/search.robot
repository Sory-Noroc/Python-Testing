*** Settings ***
Resource        ../resources/pages/search_page.resource
Test Setup     Setup Browser    ${URL}
Test Teardown  Close Browser


*** Test Cases ***
Product search with 'Enter' key
    [Tags]    search
    Search For Product And Hit Enter              Mac
    Verify Search Result Count                    4
    Verify Exact Product Titles                   iMac    MacBook    MacBook Air    MacBook Pro

Product Search using Search Button
    [Tags]    search
    Search For Product And Click Enter Button     Mac
    Verify Search Result Count                    4
    Verify Exact Product Titles                   iMac    MacBook    MacBook Air    MacBook Pro
    
Search Invalid Product Displays Empty State Message
    [Tags]    search    negative
    Search For Product And Hit Enter              magic tree
    Verify No Products Found with Message         There is no product that matches the search criteria.