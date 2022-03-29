*** Settings ***
Library    AppiumLibrary
Resource    ./keywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                AND    Create Topic Of Memo   memoTest
    ...                AND    Select Memo Topic    memoTest
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic of Memo should be able to be created
    Create Memo    noodles for dinner!
    Memo Should Be Visible    noodles for dinner!

Verify that to do field does not be filled in
    Click Edit Icon
    Click Add Icon
    Input Text On Memo Field    ${EMPTY}
    Click Ok Button
    Click Cancel Button
    Cancel Edit
    Empty Memo Should Be Visible

*** Keywords ***
Empty Memo Should Be Visible
    ${memo} =    Set Variable    //*[@resource-id="com.kiminonawa.mydiary:id/RecyclerView_memo"]
    Wait Until Element Is Visible On View    ${memo}