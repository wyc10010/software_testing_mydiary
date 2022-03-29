*** Settings ***
Library    AppiumLibrary
Library    Collections
Resource    ../commonKeywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic of Diary should be able to be updated
    [Setup]    Create Topic Of Diary    diaryTest
    Update Topic    diaryTest    updatedDiary    colorX=450    colorY=385

Verify that topic of Contact should be able to be updated
    [Setup]    Create Topic Of Contact    contactTest
    Update Topic    contactTest    updatedContact    colorX=450    colorY=385

Verify that topic of Memo should be able to be updated
    [Setup]    Create Topic Of Memo    memoTest
    Update Topic    memoTest    updatedMemo    colorX=450    colorY=385

Verify that input invalid topic name
    [Template]    Input Invalid Topic Name
    ${diary}    diaryTest    ${EMPTY}
    ${contacts}    contactTest    ${EMPTY}
    ${memo}    memoTest    ${EMPTY}

Verify that cancel button of editing topic view
    [Template]    Click Cancel Button On Edit Topic
    ${diary}    diaryTest
    ${contacts}    contactTest
    ${memo}    memoTest

*** Keywords ***
Click Cancel Button On Edit Topic
    [Arguments]    ${topicCategory}    ${originTopicName}
    Create Topic    ${originTopicName}    ${topicCategory}
    Click Edit Button On Topic View    ${originTopicName}
    Click Cancel Button On Topic Modal
    Topic Should Be Visible    ${originTopicName}

Input Invalid Topic Name
    [Arguments]    ${topicCategory}    ${originTopicName}    ${newTopicName}
    Create Topic    ${originTopicName}    ${topicCategory}
    Update Topic    ${originTopicName}    ${newTopicName}    colorX=450    colorY=385
    Click Cancel Button On Topic Modal
    Topic Should Be Visible    ${originTopicName}

Update Topic
    [Arguments]    ${originalTopicName}    ${newTopicName}    ${colorX}    ${colorY}
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_topic_detail_ok"]
    Click Edit Button On Topic View    ${newTopicName}
    Dialog Of Edit Topic Should Be Visible
    Edit Topic Name    ${newTopicName}
    Select Topic Color    ${colorX}    ${colorY}
    Click OK Button On Edit Topic Dialog

Click Edit Button On Topic View
    [Arguments]    ${topicName}
    ${topic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and @text="${topicName}"]
    ${editIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_topic_left_setting_edit"]
    Swipe    188    285    626    285
    Click Element After It Is Visible    ${editIcon}

Dialog Of Edit Topic Should Be Visible
    ${topicDetailModal} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_topic_detail_content"]
    Wait Until Element Is Visible On View    ${topicDetailModal}

Edit Topic Name
    [Arguments]    ${newTopicName}
    ${topicNameField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_topic_detail_title"]
    Clear Text    ${topicNameField}
    Run Keyword If    """${newTopicName}""" != "${EMPTY}"    Input Text After It Is Visible    ${topicNameField}    ${newTopicName}

Select Topic Color
    [Arguments]    ${x}    ${y}
    ${topicColorField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_topic_color"]
    ${colorPicker} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/picker"]
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_setting_change_color"]
    Click Element After It Is Visible    ${topicColorField}
    Wait Until Element Is Visible On View    ${colorPicker}
    &{color} =    Create Dictionary    x=${x}    y=${y}
    Click Element At Coordinates    ${color}[x]    ${color}[y]
    Click Element After It Is Visible    ${okButton}

Click OK Button On Edit Topic Dialog
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_topic_detail_ok"]
    Click Element After It Is Visible    ${okButton}