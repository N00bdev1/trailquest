*** Settings ***
Resource    ../pages/Quiz_page.robot
Resource    ../resources/locators/quiz_locators.robot
Test Setup    Navigate To Quiz Page
Test Teardown    Close Browser
*** Test Cases ***
verify quiz page loads
    [Documentation]    quiz page loads from its url
    [Tags]    1
    Page Should Contain       More Than a Quiz
Verify Question Displays
    [Documentation]    first question displays with all answers
    [Tags]    regression
    Click Quiz Button
    Page Should Contain    Question 1
    ${options}=    Get WebElements    ${OPTION_LABELS}
    FOR    ${option}    IN    @{options}
           Element Should Be Visible    ${option}
    END
Verify Answer Selection
    [Documentation]    Answer can be selected
    Click Quiz Button
    Choose Option

Verify Previous Button Functionality
    [Documentation]    previous button works
    [Tags]    slow
    Click Quiz Button
    ${progress}=    Get Text       ${QUIZ_PROGRESS}
    Choose Option
    Click Previous Button
    ${temp}=     Get Text        ${QUIZ_PROGRESS}
    IF    $temp==$progress
        Log   previous button worked
    ELSE
        Fail    previous button didn't work
    END
Verify Next Button Functionality
    [Documentation]    next button works 
    [Tags]
    Click Quiz Button
    Loop Until Next Button Appears
    ${progress_text}=    Get Text    ${QUIZ_PROGRESS}
    ${current_number}=   Get Current Question Number    ${progress_text}
    Click Next Button
    Wait Until Keyword Succeeds    5x    1s    Progress Number Should Increase By One    ${current_number}

Verify Progress Through All Questions
    [Documentation]    all questions can be answered
    [Tags]    SMOKE
    Click Quiz Button
    Loop Through Quiz
verify question counter displays
    [Documentation]    the question counter displays number of questions
    Click Quiz Button
    Wait Until Element Is Visible    ${QUIZ_PROGRESS}
    Element Should Contain    ${QUIZ_PROGRESS}    Question 1 of 13
verify form can be filled
    [Tags]    test
    Click Quiz Button
    Loop Through Quiz
    Fill The Form
    Page Should Contain    Alignment Blueprint
verify download button works
    [Tags]    hero
    Click Quiz Button
    Loop Through Quiz
    Fill The Form
    Click Download Button
verify slider works
    [Tags]    slider
    Click Quiz Button
    Loop Until Slider Appears
    Use The Slider