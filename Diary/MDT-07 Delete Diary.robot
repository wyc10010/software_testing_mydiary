*** Settings ***
Library    AppiumLibrary
Resource    ./keywords.robot
Resource    ./variables.robot

*** Test Cases ***
Verify that diary should be able to be updated
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Diary    diaryTest
    ...                 AND    Select Diary Topic    diaryTest
    ...                 AND    Select Top Bar Of Diary
    ...                 AND    Create Diary    MDT07-Title    MDT07-Content    ${cloudy}    ${normal}
    ...                 AND    Click Save Button
    ...                 AND    Diary Should Be Visible    MDT07-Title
    Click Edit Icon On Diary Entries
    Delete Diary    MDT07-Title
    Diary Should Not Be Visible    MDT07-Title
    [Teardown]    Close Application