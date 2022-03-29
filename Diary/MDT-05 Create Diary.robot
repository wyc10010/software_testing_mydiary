*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot
Resource    ./keywords.robot
Resource    ./variables.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Diary    diaryTest
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic of Diary should be able to be create diary
    Select Diary Topic    diaryTest
    Select Top Bar Of Diary
    Create Diary    MDT05-Title    MDT05-Content    ${cloudy}    ${normal}
    Click Save Button
    Diary Should Be Visible    MDT05-Title
    [Teardown]    Run Keywords    Click Edit Icon On Diary Entries
    ...                    AND    Delete Diary    MDT05-Title

Verify that only fill diary title
    Select Top Bar Of Diary
    Input Diary Title    MDT05-Title
    Click Save Button
    Hint Should Be Visible
    [Teardown]    Press Keycode    ${goBack}

Verify that only fill diary content
    Select Diary Topic    diaryTest
    Select Top Bar Of Diary
    Create Diary    ${EMPTY}    MDT05-Content    ${cloudy}    ${normal}
    Click Save Button
    Empty Topic Should Be Visible
    [Teardown]    Press Keycode    ${goBack}

Verify that create diary with image
    Select Diary Topic    diaryTest
    Select Top Bar Of Diary
    Create Diary    MDT05-Title    MDT05-Content    ${cloudy}    ${normal}
    Select Image
    Image Should Be Visible On Edit Diary Page
    Click Save Button
    [Teardown]    Run Keywords    Click Edit Icon On Diary Entries
    ...                    AND    Delete Diary    MDT05-Title

Verify that create diary with location
    Select Top Bar Of Diary
    Create Diary    MDT05-Title    MDT05-Content    ${cloudy}    ${normal}
    Select Location
    Click Save Button
    Select Diary    MDT05-Title
    Location Should Work    Amphitheatre Parkway, Mountain View, CA 94043

*** Keywords ***
Hint Should Be Visible
    ${hint} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_diary_item_content_hint" and @text="Write your diary here"]
    Wait Until Element Is Visible On View    ${hint}

Empty Topic Should Be Visible
    ${emptyTopic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_entries_item_title" and @text="No Title"]
    Wait Until Element Is Visible On View    ${emptyTopic}