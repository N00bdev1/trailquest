*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/common.robot
Resource    ../resources/locators/quiz_locators.robot
*** Variables ***
${QUIZ_URL}    ${BASE_URL}/custom/quiz
${QUIZ_BUTTON}    //button[normalize-space()='Begin The Quiz']
*** Keywords ***
Navigate to quiz page
 #   ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
#    Call Method    ${chrome_options}    add_argument    --headless
#    Call Method    ${chrome_options}    add_argument    --no-sandbox
#   Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage

    Open Browser    ${QUIZ_URL}    ${BROWSER}    #options=${chrome_options}


    Maximize Browser Window
Navigate to quiz page and maximize
    Navigate To Quiz Page
    #Maximize Browser Window
Click Quiz Button
    Wait Until Element Is Visible    ${QUIZ_BUTTON}    timeout=10s    
    Click Button    ${QUIZ_BUTTON}

Choose Option
    Wait Until Element Is Visible    ${OPTION_LABELS}    timeout=10s
    ${options}=    Get WebElements   ${OPTION_LABELS}
    Click Element  ${options}[0]

Use The Slider
    Wait Until Element Is Visible    css=#rangeInput    timeout=10s
    ${slider_el}=    Get WebElement    css=#rangeInput
    Execute Javascript    arguments[0].value = 7; arguments[0].dispatchEvent(new Event('input'));    ARGUMENTS    ${slider_el}
Click Next button
    Wait Until Element Is Enabled    ${NEXT_BTN}    timeout=10s
    Click Element                    ${NEXT_BTN}
Handle Slider Or Info Page
    Click Next Button
loop until next button appears
         WHILE    True
        ${button_appears}=    Run Keyword And Return Status
        ...    Wait Until Page Contains Element        ${NEXT_BTN}

        IF    ${button_appears}
            Exit For Loop
        END
        ${has_option}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTION_LABELS}
        IF    ${has_option}
            Choose Option
        END
     END
loop until slider appears
                  WHILE    True
        ${slider_appears}=    Run Keyword And Return Status
        ...    Wait Until Page Contains Element        ${SLIDER}

        IF    ${slider_appears}
            Exit For Loop
        END
        ${has_option}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTION_LABELS}
        IF    ${has_option}
            Choose Option
        END
     END
loop through quiz
        WHILE    True
        ${completed}=    Run Keyword And Return Status
        ...    Wait Until Page Contains Element        ${Blueprint_Form}

        IF    ${completed}
            Exit For Loop
        END
        ${has_option}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTION_LABELS}
        IF    ${has_option}
            Choose Option
        ELSE
            Handle Slider Or Info Page
        END

    END
Get current question number
    [Arguments]    ${progress_text}
    ${number}=     Evaluate    int('${progress_text}'.split()[1])
    RETURN    ${number}
progress number should increase by one
    [Arguments]    ${previous_number}
    ${progress_text}=    Get Text    ${QUIZ_PROGRESS}
    ${current_number}=     Get Current Question Number    ${progress_text}
    Should Be Equal As Integers    ${current_number}    ${previous_number + 1}
Click previous Button
    Wait Until Element Is Visible    ${PREVIOUS_BUTTON}
    Click Element    ${PREVIOUS_BUTTON}
Fill the form
    Input Text    ${name}    Alison Maharjan
    Input Text    ${email}    alsonmaharjan10@gmail.com    
    Input Text    ${contact}    9847309490
    Click Button    ${Blueprint_Form_Button}
click download button
    Wait Until Element Is Visible    ${download_button}
    Click Element    ${download_button}
