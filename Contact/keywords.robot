*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot

*** Keywords ***
Select Contact Topic
    [Arguments]    ${contactTopicName}
    Wait Until Element Is Visible On View    //android.widget.TextView[@text="${contactTopicName}"]
    Click Element After It Is Visible    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title"]
    Wait Until Element Is Visible On View    //android.widget.TextView[@text="${contactTopicName}"]

Create Contact
    [Arguments]    ${name}    ${phone}
    Click Add Icon On Contact
    Input Contact Person Name    ${name}
    Input Contact Person Phone    ${phone}
    Click Ok Button On Contact Dialog

Click Add Icon On Contact
    ${addIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_contacts_add"]
    ${contactModal} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_contacts_detail_top_content"]
    Click Element After It Is Visible    ${addIcon}
    Wait Until Element Is Visible On View    ${contactModal}

Input Contact Person Name
    [Arguments]    ${name}
    ${nameField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_contacts_detail_name"]
    Wait Until Element Is Visible On View    ${nameField}
    Input Text After It Is Visible    ${nameField}    ${name}

Input Contact Person Phone
    [Arguments]    ${phone}
    ${phoneField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_contacts_detail_phone_number"]
    Wait Until Element Is Visible On View    ${phoneField}
    Input Text After It Is Visible    ${phoneField}    ${phone}

Click Ok Button On Contact Dialog
    ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_contacts_detail_ok"]
    Click Element After It Is Visible    ${okButton}

Contact Should Be Visible
    [Arguments]    ${name}    ${phone}
    ${personName} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_contacts_name" and @text="${name}"]
    ${personPhone} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_contacts_phone_number" and @text="${phone}"]
    Wait Until Element Is Visible On View    ${personName}
    Wait Until Element Is Visible On View    ${personPhone}

Contact Should Not Be Visible
    [Arguments]    ${name}    ${phone}
    ${personName} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_contacts_name" and @text="${name}"]
    ${personPhone} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_contacts_phone_number" and @text="${phone}"]
    Wait Until Page Does Not Contain Element    ${personName}
    Wait Until Page Does Not Contain Element    ${personPhone}

Enter Edit Contact Page
    [Arguments]    ${phone}
    ${personPhone} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_contacts_phone_number" and @text="${phone}"]
    ${contactModal} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/LL_contacts_detail_top_content"]
    Wait Until Element Is Visible On View    ${personPhone}
    Long Press    ${personPhone}
    Wait Until Element Is Visible On View    ${contactModal}

Click Cancel Button On Contact Modal
    ${cancelButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_contacts_detail_cancel"]
    Click Element After It Is Visible    ${cancelButton}