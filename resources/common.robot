*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BASE_URL}    https://trailquest.global
${BROWSER}    CHROME


*** Keywords ***
Open Website and Maximize
     Open Browser    ${BASE_URL}    ${BROWSER}
     Maximize Browser Window