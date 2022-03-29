*** Settings ***
Library    AppiumLibrary
Library    Collections
Resource    ../commonKeywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic of Diary should be able to be deleted
    Create Topic Of Diary    diaryTest
    Delete Topic    diaryTest

Verify that topic of Contact should be able to be deleted
    Create Topic Of Contact    contactTest
    Delete Topic    contactTest

Verify that topic of Memo should be able to be deleted
    Create Topic Of Memo    memoTest
    Delete Topic    memoTest

*** Keywords ***
Click Delete Button On Topic View
    [Arguments]    ${topicName}
    ${topic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and @text="${topicName}"]
    ${deleteIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_topic_left_setting_delete"]
    Swipe    188    285    626    285
    Click Element After It Is Visible    ${deleteIcon}

Click OK Button On Delete Topic Dialog
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_common_ok"]
    Click Element After It Is Visible    ${okButton}

Check Topic Should Not Be Existing
    [Arguments]    ${topicName}
    ${topic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and @text="${topicName}"]
    Wait Until Page Does Not Contain Element    ${topic}

Delete Topic
    [Arguments]    ${topicName}
    Click Delete Button On Topic View    ${topicName}
    Click OK Button On Delete Topic Dialog
    Check Topic Should Not Be Existing    ${topicName}