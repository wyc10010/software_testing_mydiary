*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic should be able to created
    Create Topic Of Diary    diaryTest
    Topic Should Be Visible    diaryTest
    Create Topic Of Contact    contactsTest
    Topic Should Be Visible    contactsTest
    Create Topic Of Memo    memoTest
    Topic Should Be Visible    memoTest

Verify that topic should not be able to created when topic name is empty
    [Template]    Topic Should Not Be Created
    ${diary}    ${EMPTY}
    ${contacts}    ${EMPTY}
    ${memo}    ${EMPTY}

*** Keywords ***
Topic Should Not Be Created
    [Arguments]    ${topicCategory}    ${topicName}
    Create Topic    ${topicName}    ${topicCategory}
    Click Cancel Button On Topic Modal
    Topic Should Not Be Visible    ${topicName}