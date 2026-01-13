*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/common.robot
Resource    ../resources/locators/quiz_locators.robot
Resource    ../pages/quiz_page.robot

*** Test Cases ***
Right Click On Element
    Open Browser    https://www.google.com/search?sxsrf=ANbL-n7WsVmzw4d1UVgffHb1K_j_-DOLFQ:1767872751298&udm=2&q=download+a+file&aic=0  chrome


  
