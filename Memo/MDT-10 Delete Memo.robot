*** Settings ***
Library    AppiumLibrary
Resource    ./keywords.robot
Resource    ../commonKeywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                AND    Create Topic    memoTest    ${memo}
    ...                AND    Select Memo Topic    memoTest
Suite Teardown    Close Application

*** Test Cases ***
Delete Memo
    Create Memo    noodles for dinner!
    Click Edit Icon
    Click Delete Icon    noodles for dinner!
    Cancel Edit
    Memo Should Not Be Visible    noodles for dinner!