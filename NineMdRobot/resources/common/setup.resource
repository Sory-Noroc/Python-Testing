*** Settings ***
Library            SeleniumLibrary
Variables          ${CURDIR}/../../config/production.yaml


*** Keywords ***
Start Browser and Access Url
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
