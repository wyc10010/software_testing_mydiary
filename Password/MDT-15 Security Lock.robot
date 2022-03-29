*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot

*** Variables ***
${1} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_1"]
${2} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_2"]
${3} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_3"]
${4} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_4"]
${5} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_5"]
${6} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_6"]
${7} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_7"]
${8} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_8"]
${9} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_9"]
${0} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_0"]
${backSpace} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_backspace"]
${cancel} =    //*[@resource-id="com.kiminonawa.mydiary:id/But_password_key_cancel"]

*** Test Cases ***
Verify that password should be able to created and enter app successfully
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    Click Password Setting
    Enter Password    ${0}    ${0}    ${0}    ${0}
    Confirm Password    ${0}    ${0}    ${0}    ${0}
    Close My Diary Application By App Switch Button
    Open My Diary Application With Password
    Password Page Should Be Visible
    Enter Password    ${0}    ${0}    ${0}    ${0}
    Click OK Button On Release Note Model
    On The Home Page
    [Teardown]    Close Application

Verify that confirm password should be the same with enter password
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    Click Password Setting
    Enter Password    ${0}    ${0}    ${0}    ${0}
    Confirm Password    ${0}    ${0}    ${0}    ${1}
    Confirm Password Does Not Match
    [Teardown]    Close Application

Verify that password should not be able to enter app
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    Click Password Setting
    Enter Password    ${0}    ${0}    ${0}    ${0}
    Confirm Password    ${0}    ${0}    ${0}    ${0}
    Close My Diary Application By App Switch Button
    Open My Diary Application With Password
    Password Page Should Be Visible
    Enter Password    ${0}    ${0}    ${0}    ${1}
    Confirm Password Does Not Match
    [Teardown]    Close Application

Verify that password should be able to removed
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Click Password Setting
    ...                 AND    Enter Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Confirm Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Close My Diary Application By App Switch Button
    ...                 AND    Open My Diary Application With Password
    ...                 AND    Password Page Should Be Visible
    ...                 AND    Enter Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Click OK Button On Release Note Model
    ...                 AND    On The Home Page
    Click Password Setting
    Remove Password Page Should Be Visible
    Enter Password    ${0}    ${0}    ${0}    ${0}
    Close My Diary Application By App Switch Button
    Open My Diary Application Without Password
    Click OK Button On Release Note Model
    On The Home Page
    [Teardown]    Close Application

Verify that password should not be able to removed
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Click Password Setting
    ...                 AND    Enter Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Confirm Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Close My Diary Application By App Switch Button
    ...                 AND    Open My Diary Application With Password
    ...                 AND    Password Page Should Be Visible
    ...                 AND    Enter Password    ${0}    ${0}    ${0}    ${0}
    ...                 AND    Click OK Button On Release Note Model
    ...                 AND    On The Home Page
    Click Password Setting
    Remove Password Page Should Be Visible
    Enter Password    ${0}    ${0}    ${0}    ${1}
    Old Password Does Not Match
    [Teardown]    Close Application

*** Keywords ***
Click Password Setting
    ${settinrIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_main_setting"]
    ${passwordIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_main_setting_setting_security"]
    ${passwordPage} =    Set Variable    //android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout
    Click Element After It Is Visible    ${settinrIcon}
    Wait Until Element Is Visible On View    ${scrollBar}
    Click Element After It Is Visible    ${passwordIcon}
    Wait Until Element Is Visible On View    ${passwordPage}

Enter Password
    [Arguments]    ${first}    ${second}    ${third}    ${fourth}
    Click Element    ${first}
    Click Element    ${second}
    Click Element    ${third}
    Click Element    ${fourth}

Confirm Password
    [Arguments]    ${first}    ${second}    ${third}    ${fourth}
    Click Element    ${first}
    Click Element    ${second}
    Click Element    ${third}
    Click Element    ${fourth}

Password Page Should Be Visible
    ${enterPasswordToApp} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_password_message" and @text="Enter passcode"]
    Wait Until Element Is Visible On View    ${enterPasswordToApp}

Open My Diary Application With Password
    Click Element After It Is Visible    //android.widget.TextView[@content-desc="MyDiary"]
    Password Page Should Be Visible

Open My Diary Application Without Password
    Click Element After It Is Visible    //android.widget.TextView[@content-desc="MyDiary"]
    ${enterPasswordToApp} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_password_message" and @text="Enter passcode"]
    Wait Until Page Does Not Contain Element    ${enterPasswordToApp}

Close My Diary Application By App Switch Button
    Press Keycode    187
    Click Element After It Is Visible    //*[@resource-id="com.android.systemui:id/dismiss_task"]

Warning Message Should Be Visible
    [Arguments]    ${warningText}
    ${message} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_password_sub_message" and @text="${warningText}"]
    Wait Until Element Is Visible On View    ${message}

Confirm Password Does Not Match
    Warning Message Should Be Visible    Passcode does not match

Old Password Does Not Match
    Warning Message Should Be Visible    Old passcode does not match

Remove Password Page Should Be Visible
    ${removePasswordText} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_password_message" and @text="Enter passcode to remove lock"]
    Wait Until Element Is Visible On View    ${removePasswordText}