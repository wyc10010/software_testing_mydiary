*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot
Resource    ./variables.robot

*** Keywords ***
Select Diary Topic
    [Arguments]    ${diaryTopicName}
    Wait Until Element Is Visible On View    //android.widget.TextView[@text="${diaryTopicName}"]
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title"]
    Wait Until Element Is Visible On View    //android.widget.TextView[@text="${diaryTopicName}"]

Select Top Bar Of Diary
    Click Element After It Is Visible    ${topBarOfDiary}

Input Diary Title
    [Arguments]    ${diaryTitle}
    ${diaryTitleField} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.EditText
    Wait Until Element Is Visible On View    ${diaryTitleField}
    Input Text After It Is Visible    ${diaryTitleField}    ${diaryTitle}

Input Diary Content
    [Arguments]    ${diaryContent}
    ${diaryContentField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_diary_item_content"]
    Wait Until Element Is Visible On View    ${diaryContentField}
    Input Text After It Is Visible    ${diaryContentField}    ${diaryContent}

Choose Weather
    [Arguments]    ${diaryWeather}
    ${weatherList} =    Set Variable    //android.widget.FrameLayout/android.widget.ListView
    ${weather} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.RelativeLayout[1]/android.widget.Spinner/android.widget.ImageView
    Wait Until Element Is Visible On View    ${weather}
    Click Element After It Is Visible    ${weather}
    Wait Until Element Is Visible On View    ${weatherList}
    Click Element After It Is Visible    ${diaryWeather}
    Wait Until Element Is Visible On View    ${weather}

Choose Mood
    [Arguments]    ${diaryMood}
    ${moodList} =    Set Variable    //android.widget.FrameLayout/android.widget.ListView
    ${mood} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.support.v4.view.ViewPager/android.widget.RelativeLayout/android.widget.ScrollView/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.LinearLayout/android.widget.RelativeLayout[2]/android.widget.Spinner/android.widget.ImageView
    Wait Until Element Is Visible On View    ${mood}
    Click Element After It Is Visible    ${mood}
    Wait Until Element Is Visible On View    ${moodList}
    Click Element After It Is Visible    ${moodList}
    Wait Until Element Is Visible On View    ${mood}

Click Save Button
    ${saveButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_save"]
    Wait Until Page Contains Element    ${saveButton}
    Click Element    ${saveButton}

Create Diary
    [Arguments]    ${diaryTitle}    ${diaryContent}    ${weather}    ${mood}
    Input Diary Title    ${diaryTitle}
    Input Diary Content    ${diaryContent}
    Choose Weather    ${weather}
    Choose Mood    ${mood}
    Press Keycode    ${goBack}
# TODO Input Diary Photo and Location

Diary Should Be Visible
    [Arguments]    ${diaryTitle}
    ${diaryTitleField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_entries_item_title" and contains(@text, ${diaryTitle})]
    Wait Until Element Is Visible On View    ${diaryTitleField}

Click Edit Icon On Diary Entries
    ${editIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_entries_edit"]
    Click Element After It Is Visible    ${editIcon}

Select Diary
    [Arguments]    ${diaryName}
    Click Element After It Is Visible    //android.widget.TextView[@text="${diaryName}"]

Select Location
    ${locationIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_location"]
    ${googleLocation} =    Set Variable    //*[@resource-id="com.google.android.gms:id/select_marker_location"]
    ${comfirmButton} =    Set Variable    //*[@resource-id="com.google.android.gms:id/confirm_button"]
    Click Element After It Is Visible    ${locationIcon}
    Click Element After It Is Visible    ${googleLocation}
    Click Element After It Is Visible    ${comfirmButton}

Location Should Work
    [Arguments]    ${location}
    ${location} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_diary_location" and @text="${location}"]
    Wait Until Element Is Visible On View    ${location}    error=Location bug.

Select Image
    ${picIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_photo"]
    ${album} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_photo_select_a_photo"]
    ${gallery} =    Set Variable    //*[@resource-id="android:id/title" and @text="Gallery"]
    ${grid} =    Set Variable    //*[@resource-id="com.android.gallery:id/grid"]
    Click Element After It Is Visible    ${picIcon}
    Click Element After It Is Visible    ${album}
    Click Element After It Is Visible    ${gallery}
    Wait Until Element Is Visible On View    ${grid}
    Click Element At Coordinates    155    213

Image Should Be Visible On Edit Diary Page
    ${diaryTitle} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_diary_title"]
    ${photo} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/SDV_diary_new_photo"]
    Wait Until Element Is Visible On View    ${diaryTitle}
    Wait Until Element Is Visible On View    ${photo}

Image Text Should Be Visible On Diary Entries
    ${photoText} =    Set Variable    //*[@resource-id="//*[@resource-id="com.kiminonawa.mydiary:id/TV_entries_item_summary" and @text="**photo**"]
    Wait Until Element Is Visible On View    ${photoText}

Delete Diary
    [Arguments]    ${diaryTitle}
    Select Diary    ${diaryTitle}
    Click Delete Button On Edit Diary Dialog
    Warning Dialog::Click OK Button

Click Delete Button On Edit Diary Dialog
    ${deleteButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_diary_delete"]
    ${warningDialog} =    Set Variable    //android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout
    Click Element After It Is Visible    ${deleteButton}
    Wait Until Element Is Visible On View    ${warningDialog}

Warning Dialog::Click OK Button
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_common_ok"]
    ${warningDialog} =    Set Variable    //android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout
    Wait Until Element Is Visible On View    ${warningDialog}
    Click Element After It Is Visible    ${okButton}

Diary Should Not Be Visible
    [Arguments]    ${diaryTitle}
    ${diaryTitleField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_entries_item_title" and contains(@text, ${diaryTitle})]
    Wait Until Page Does Not Contain Element    ${diaryTitleField}