*** Settings ***
Library    AppiumLibrary
Resource    ./keywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                AND    Create Topic    memoTest    ${memo}
    ...                AND    Select Memo Topic    memoTest
Suite Teardown    Close Application

*** Test Cases ***
Verify that memo should be able to be updated
    Create Memo    noodles for dinner!
    Click Edit Icon
    Click Memo    noodles for dinner!
    Clear Text    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content"]
    Input Text On Memo Field    rice for dinner!
    Click Ok Button
    Cancel Edit
    Memo Should Be Visible    rice for dinner!
    [Teardown]    Delete Memo    rice for dinner!

Verify that empty memo should not be able to be updated
    Create Memo    noodles for dinner!
    Click Edit Icon
    Click Memo    noodles for dinner!
    Clear Text    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content"]
    Input Text On Memo Field    ${EMPTY}
    Click Ok Button
    Click Cancel Button On Memo Modal
    Cancel Edit
    Memo Should Be Visible    noodles for dinner!
    [Teardown]    Delete Memo    noodles for dinner!

Verify that two memo should be able to be swipe
    ${orgDont} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout[2]/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[1]/android.widget.TextView
    ${orgNoodles} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout[2]/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[2]/android.widget.TextView
    ${newDont} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout[2]/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[2]/android.widget.TextView
    ${newNoodles} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout[2]/android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[1]/android.widget.TextView
    Create Memo    noodles for dinner!
    Create Memo    I dont know!
    Check Memo Order    ${orgDont}    I dont know!
    Check Memo Order    ${orgNoodles}    noodles for dinner!
    Click Edit Icon
    Swipe    59    373    59    527
    Cancel Edit
    Check Memo Order    ${newDont}    I dont know!
    Check Memo Order    ${newNoodles}    noodles for dinner!
    [Teardown]    Run Keywords    Delete Memo    noodles for dinner!
    ...                    AND    Delete Memo    I dont know!

Verify that cancel button of editing memo view
    Create Memo    noodles for dinner!
    Click Edit Icon
    Click Memo    noodles for dinner!
    Click Cancel Button On Memo Modal
    Cancel Edit
    Memo Should Be Visible    noodles for dinner!
    [Teardown]    Delete Memo    noodles for dinner!

*** Keywords ***
Check Memo Order
    [Arguments]    ${xpath}    ${memo}
    Click Edit Icon
    Click Element    ${xpath}
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content" and @text="${memo}"]
    Click Ok Button
    Cancel Edit

Click Cancel Button On Memo Modal
    ${cancelButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_edit_memo_cancel"]
    Click Element After It Is Visible    ${cancelButton}

Click Memo Topic
    [Arguments]    ${memoName}
    ${memoTopic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and contains(@text, "${memoName}")]
    Wait Until Element Is Visible On View    ${memoTopic}
    Click Element After It Is Visible    ${memoTopic}