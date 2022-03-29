*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot
Resource    ./keywords.robot

*** Test Cases ***
Verify that contact should be able to be deleted
    [Setup]    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Contact    contactTest
    ...                 AND    Select Contact Topic    contactTest
    ...                 AND    Create Contact    MM    0912345678
    ...                 AND    Contact Should Be Visible    MM    0912345678
    Enter Edit Contact Page    0912345678
    Click Delete Button On Contact Dialog
    Contact Should Not Be Visible    MM    0912345678
    [Teardown]    Close Application

*** Keywords ***
Click Delete Button On Contact Dialog
    ${deleteButton} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/But_contacts_detail_delete"]
    Click Element After It Is Visible    ${deleteButton}