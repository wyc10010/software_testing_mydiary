*** Settings ***
Library    AppiumLibrary
Library    Collections
Library    ../util.py
Resource    ../commonKeywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topics Of Diary     @{diaryNames}
Suite Teardown    Close Application

*** Variables ***
${searchBar} =    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_main_topic_search"]
@{diaryNames} =    diaryTest1    diaryTest2    diaryTest3
${ENTER} =    13
${goBack} =    4

*** Test Cases ***
Verify that search bar should be able to be search for topic
    Search Text For Topic    diary    4
    [Teardown]    Clear Text    ${searchBar}

Verify that search bar should be able to be search when topic is not exist
    Search Text When Topic Is Not Exist    memo
    [Teardown]    Clear Text    ${searchBar}

*** Keywords ***
Create Topics Of Diary
    [Arguments]    @{dirayNames}
    FOR    ${dirayName}    IN    @{dirayNames}
        Create Topic Of Diary    ${dirayName}
    END

Search Text For Topic
    [Arguments]    ${searchedTopicName}    ${expectedTopicCount}
    ${topicTitles} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RL_topic_view"]//*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title"]
    @{actualTopics} =  Create List
    Click Element After It Is Visible    ${searchBar}
    Input Text After It Is Visible    ${searchBar}    ${searchedTopicName}
    @{elements} =    Get Webelements    ${topicTitles}
    FOR    ${element}    IN    @{elements}
        ${getText} =    Get Text    ${element}
        Append To List    ${actualTopics}    ${getText}
    END
    Search Results Should Contain Searching Text    ${searchedTopicName}    ${actualTopics}
    ${autualTopicCount} =    Get Matching Xpath Count    ${topicTitles}
    Should Be Equal    ${expectedTopicCount}    ${autualTopicCount}
    # Search texts are not case sensitive, default topic: DIRAY

Search Text When Topic Is Not Exist
    [Arguments]    ${searchedTopicName}
    ${searchBar} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_main_topic_search"]
    ${topicTitles} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RL_topic_view"]//*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title"]
    ${emptyTopic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_topic"]
    Click Element After It Is Visible    ${searchBar}
    Input Text After It Is Visible    ${searchBar}    ${searchedTopicName}
    Press Keycode    ${goBack}
    Press Keycode    ${ENTER}
    Wait Until Element Is Visible    ${emptyTopic}