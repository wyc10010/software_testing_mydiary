*** Settings ***
Library    AppiumLibrary
Resource    ./commonVariables.robot

*** Keywords ***
Wait Until Element Is Visible On View
    [Arguments]    ${locator}    ${error}=${EMPTY}
    Wait Until Page Contains Element    ${locator}    timeout=3s    error=Element should be visible.
    Wait Until Element Is Visible    ${locator}    timeout=3s    error=${error}

Click Element After It Is Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible On View    ${locator}
    Click Element    ${locator}

Input Text After It Is Visible
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible On View    ${locator}
    Input Text    ${locator}    ${text}

Open My Diary Application
    Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    deviceName=emulator-5554    appPackage=com.kiminonawa.mydiary    appActivity=com.kiminonawa.mydiary.init.InitActivity
    Wait Until Element Is Visible On View    com.kiminonawa.mydiary:id/imageView
    Wait Until Element Is Visible On View    com.kiminonawa.mydiary:id/TV_init_message
    Out-of-box Experience For First Use
    # Click OK Button On Release Note Model

Out-of-box Experience For First Use
    ${nextButton} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout[1]/android.widget.Button
    Click OK Button On Release Note Model
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/action_bar_root"]
    Click Element After It Is Visible    ${nextButton}
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_topic"]
    Click Element After It Is Visible    ${nextButton}
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_topic"]
    Click Element After It Is Visible    ${nextButton}
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_topic"]
    Click Element After It Is Visible    ${nextButton}
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_topic"]
    Click Element After It Is Visible    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout[1]/android.widget.Button
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/activity_main"]

Click OK Button On Release Note Model
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/RL_release_note"]
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/But_release_note_ok"]

On The Home Page
    Wait Until Element Is Visible On View    //*[@resource-id="com.kiminonawa.mydiary:id/activity_main"]

Create Topic
    [Arguments]    ${topicName}    ${topic}
    ${okBtn} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_topic_detail_ok"]
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/IV_main_setting"]
    Wait Until Element Is Visible On View    ${scrollBar}
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/IV_main_setting_add_topic"]
    Wait Until Element Is Visible On View    ${topicDetail}
    Input Text After It Is Visible    ${inputField}    ${topicName}
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/SP_topic_detail_type"]
    Wait Until Element Is Visible On View    ${topicDropdown}
    Click Element After It Is Visible    ${topic}
    Wait Until Element Is Visible On View    ${topicDetail}
    Click Element After It Is Visible    ${okBtn}

Topic Should Be Visible
    [Arguments]    ${topicName}
    Wait Until Element Is Visible On View    //android.widget.TextView[@text="${topicName}"]

Create Topic Of Diary
    [Arguments]    ${topicOfDiaryName}
    Create Topic    ${topicOfDiaryName}    ${diary}
    Topic Should Be Visible    ${topicOfDiaryName}

Create Topic Of Contact
    [Arguments]    ${topicOfContactName}
    Create Topic    ${topicOfContactName}    ${contacts}
    Topic Should Be Visible    ${topicOfContactName}

Create Topic Of Memo
    [Arguments]    ${topicOfMemoName}
    Create Topic    ${topicOfMemoName}    ${memo}
    Topic Should Be Visible    ${topicOfMemoName}

Click Cancel Button On Topic Modal
    ${cancelButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_topic_detail_cancel"]
    Click Element After It Is Visible    ${cancelButton}

Topic Should Not Be Visible
    [Arguments]    ${topicName}
    ${topic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and @text="${topicName}"]
    Wait Until Page Does Not Contain Element    ${topic}