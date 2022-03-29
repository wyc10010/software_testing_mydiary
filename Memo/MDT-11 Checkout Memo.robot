# *** Settings ***
# Library    AppiumLibrary
# Resource    ./keywords.robot
# Resource    ../commonKeywords.robot
# Test Setup    Run Keywords    Open My Diary Application
# ...                    AND    Create Topic    memoTest    ${memo}
# Test Teardown    Close Application

# *** Test Cases ***
# Log
    # Log    123

# *** Keywords ***
# Create Memo
    # Click Memo Topic    memoTest
    # Click Edit Icon
    # Click Add Icon
    # Input Text On Memo Field    noodles for dinner!
    # Click Ok Button
    # Cancel Edit
    # Memo Should Be Visible    noodles for dinner!

# Click Memo Topic
    # [Arguments]    ${memoName}
    # ${memoTopic} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_topic_title" and contains(@text, "${memoName}")]
    # Wait Until Element Is Visible On View    ${memoTopic}
    # Click Element After It Is Visible    ${memoTopic}

# Click Edit Icon
    # ${editIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_memo_edit"]
    # ${addIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/Layout_memo_item_add"]
    # Click Element After It Is Visible    ${editIcon}
    # Wait Until Element Is Visible On View    ${addIcon}
    
# Cancel Edit
    # ${editIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/IV_memo_edit"]
    # Click Element After It Is Visible    ${editIcon}

# Click Add Icon
    # ${addIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/Layout_memo_item_add"]
    # ${memoField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content"]
    # Click Element After It Is Visible    ${addIcon}
    # Wait Until Element Is Visible On View    ${memoField}

# Input Text On Memo Field
    # [Arguments]    ${memoText}
    # ${memoField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content"]
    # Wait Until Element Is Visible On View    ${memoField}
    # Input Text After It Is Visible    ${memoField}    ${memoText}

# Click Ok Button
    # ${okButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_edit_memo_ok"]
    # Click Element After It Is Visible    ${okButton}

# Memo Should Be Visible
    # [Arguments]    ${memoText}
    # ${memo} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_memo_item_content" and contains(@text, "${memoText}")]
    # Wait Until Element Is Visible On View    ${memo}

# Memo Should Not Be Visible
    # [Arguments]    ${memoText}
    # ${memo} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_memo_item_content" and contains(@text, "${memoText}")]
    # Wait Until Page Does Not Contain    ${memo}

# Click Memo
    # [Arguments]    ${memoText}
    # ${memo} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/TV_memo_item_content" and contains(@text, "${memoText}")]
    # ${memoField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_edit_memo_content"]
    # Click Element After It Is Visible    ${memo}
    # Wait Until Element Is Visible On View    ${memoField}

# Click Delete Icon
    # [Arguments]    ${memoText}
    # ${deleteIcon} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RL_memo_item_root_view"]//*[@resource-id="com.kiminonawa.mydiary:id/TV_memo_item_content" and contains(@text, "${memoText}")]//parent::*//*[@resource-id="com.kiminonawa.mydiary:id/IV_memo_item_delete"]
    # Click Element After It Is Visible    ${deleteIcon}