*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot
Resource    ./keywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Contact    contactTest
    ...                 AND    Select Contact Topic    contactTest
    ...                 AND    Create Contact    JJ    0912345678
    ...                 AND    Contact Should Be Visible    JJ    0912345678
Suite Teardown    Close Application


*** Test Cases ***
Verify that empty name of contact should not be able to be updated
    Enter Edit Contact Page    0912345678
    Update Contact    ${EMPTY}    0000000001
    Click Cancel Button On Contact Modal
    Contact Should Be Visible    JJ    0912345678

Verify that empty phone of contact should not be able to be updated
    Enter Edit Contact Page    0912345678
    Update Contact    KK    ${EMPTY}
    Click Cancel Button On Contact Modal
    Contact Should Be Visible    JJ    0912345678

Verify that empty all of contact should not be able to be updated
    Enter Edit Contact Page    0912345678
    Update Contact    ${EMPTY}    ${EMPTY}
    Click Cancel Button On Contact Modal
    Contact Should Be Visible    JJ    0912345678

Verify that cancel button of editing contact view
    Enter Edit Contact Page    0912345678
    Click Cancel Button On Contact Modal
    Contact Should Be Visible    JJ    0912345678

Verify that contact should be able to be updated
    Enter Edit Contact Page    0912345678
    Update Contact    KK    0000000001
    Contact Should Be Visible    KK    0000000001

*** Keywords ***
Update Contact
    [Arguments]    ${name}    ${phone}
    Update Contact Person Name    ${name}
    Update Contact Person Phone    ${phone}
    Click Ok Button On Contact Dialog

Update Contact Person Name
    [Arguments]    ${personName}=${EMPTY}
    ${nameField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_contacts_detail_name"]
    Wait Until Element Is Visible On View    ${nameField}
    Clear Text    ${nameField}
    Input Text After It Is Visible    ${nameField}    ${personName}

Update Contact Person Phone
    [Arguments]    ${personPhone}=${EMPTY}
    ${phoneField} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/EDT_contacts_detail_phone_number"]
    Wait Until Element Is Visible On View    ${phoneField}
    Clear Text    ${phoneField}
    Input Text After It Is Visible    ${phoneField}    ${personPhone}