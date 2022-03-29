*** Settings ***
Library    AppiumLibrary
Resource    ./keywords.robot
Resource    ./variables.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Diary    diaryTest
    ...                 AND    Select Diary Topic    diaryTest
    ...                 AND    Select Top Bar Of Diary
    ...                 AND    Create Diary    MDT06-Title    MDT06-Content    ${cloudy}    ${normal}
    ...                 AND    Click Save Button
    ...                 AND    Diary Should Be Visible    MDT06-Title
Suite Teardown    Close Application

*** Test Cases ***
Verify that diary should be able to be updated
    Click Edit Icon On Diary Entries
    Update Diary    MDT06-Title    ${sunny}    ${happy}    newTitle    newContent
    Click Save Button On Edit Diary Dialog

Verify that diary image should be able to be updated
    Click Edit Icon On Diary Entries
    Update Diary    newTitle    ${sunny}    ${happy}    MDT06-Title    ${EMPTY}
    Select Image
    Image Should Be Visible On Edit Diary Page
    Click Save Button On Edit Diary Dialog

Verify that ok button of editing diary view
    Click Edit Icon On Diary Entries
    Select Diary    MDT06-Title
    Click Close Button On Edit Diary Dialog
    Click OK Button On Edit Diary Dialog
    Diary Should Be Visible    MDT06-Title

Verify that cancel button of editing diary view
    Click Edit Icon On Diary Entries
    Select Diary    MDT06-Title
    Click Close Button On Edit Diary Dialog
    Click Cancel Button On Edit Diary Dialog
    Diary Content Should Be Visible
    [Teardown]    Run Keywords    Click Close Button On Edit Diary Dialog
    ...                    AND    Click OK Button On Edit Diary Dialog

Verify that diary location should be able to be updated
    Click Edit Icon On Diary Entries
    Update Diary    MDT06-Title    ${sunny}    ${happy}    MDT06-Title    newContent
    Select Location
    Click Save Button On Edit Diary Dialog

*** Keywords ***
Update Diary
    [Arguments]    ${originalDiary}    ${newWeather}    ${newMood}    ${newDirayTitle}=${EMPTY}    ${newDiaryContent}=${EMPTY}
    Select Diary    ${originalDiary}
    Update Diary Title    ${newDirayTitle}
    Update Diary Content    ${newDiaryContent}
    Update Weather    ${newWeather}
    Update Mood    ${newMood}
    Press Keycode    ${goBack}

Update Diary Title
    [Arguments]    ${diaryTitle}=${EMPTY}
    ${diaryTitleField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_diary_title"]
    Wait Until Element Is Visible On View    ${diaryTitleField}
    Run Keyword If    """${diaryTitle}""" != "${EMPTY}"    Run Keywords    Clear Text    ${diaryTitleField}
    ...        AND    Input Text After It Is Visible    ${diaryTitleField}    ${diaryTitle}

Update Diary Content
    [Arguments]    ${diaryContent}=${EMPTY}
    ${diaryContentField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_diary_item_content"]//android.widget.EditText
    ${diaryEmptyContentField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_diary_item_content"]//*[@text=""]
    Wait Until Element Is Visible On View    ${diaryContentField}
    Run Keyword If    """${diaryContent}""" != "${EMPTY}"    Run Keywords    Clear Text    ${diaryContentField}
    ...        AND    Wait Until Element Is Visible On View    ${diaryEmptyContentField}
    ...        AND    Input Text After It Is Visible    ${diaryContentField}    ${diaryContent}

Update Weather
    [Arguments]    ${diaryWeather}
    ${weatherList} =    Set Variable    //*[@class="android.widget.ListView"]
    ${weather} =    Set Variable    //android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.RelativeLayout[1]/android.widget.Spinner/android.widget.ImageView
    Wait Until Element Is Visible On View    ${weather}
    Click Element After It Is Visible    ${weather}
    Wait Until Element Is Visible On View    ${weatherList}
    Click Element After It Is Visible    ${diaryWeather}
    Wait Until Element Is Visible On View    ${weather}

Update Mood
    [Arguments]    ${diaryMood}
    ${moodList} =    Set Variable    //android.widget.FrameLayout/android.widget.ListView
    ${mood} =    Set Variable    //android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.RelativeLayout[2]/android.widget.Spinner/android.widget.ImageView
    Wait Until Element Is Visible On View    ${mood}
    Click Element After It Is Visible    ${mood}
    Wait Until Element Is Visible On View    ${moodList}
    Click Element After It Is Visible    ${moodList}
    Wait Until Element Is Visible On View    ${mood}

Click Save Button On Edit Diary Dialog
    ${saveButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_save"]
    Wait Until Page Contains Element    ${saveButton}
    Click Element    ${saveButton}

Diary Content Should Be Visible
    ${diaryContent} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RL_diary_content"]
    Wait Until Element Is Visible On View    ${diaryContent}

Click Close Button On Edit Diary Dialog
    ${closeButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_close_dialog"]
    Click Element After It Is Visible    ${closeButton}

Click OK Button On Edit Diary Dialog
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_common_ok"]
    Click Element After It Is Visible    ${okButton}

Click Cancel Button On Edit Diary Dialog
    ${cancelButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_common_cancel"]
    Click Element After It Is Visible    ${cancelButton}