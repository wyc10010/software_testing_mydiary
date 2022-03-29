*** Settings ***
Library    AppiumLibrary
Resource    ../commonKeywords.robot
Resource    ./keywords.robot

Suite Setup    Run Keywords    Open My Diary Application
    ...                 AND    On The Home Page
    ...                 AND    Create Topic Of Contact    contactTest
    ...                 AND    Select Contact Topic    contactTest
Suite Teardown    Close Application

*** Test Cases ***
Verify that topic of Contact should be able to be create contact
    Create Contact    JJ    0912345678
    Contact Should Be Visible    JJ    0912345678

Verify that only fill name of contact
    Create Contact    apple    ${EMPTY}
    Click Cancel Button On Contact Modal
    Contact Should Not Be Visible    apple    ${EMPTY}

Verify that only fill phone of contact
    Create Contact    ${EMPTY}    0912645678
    Click Cancel Button On Contact Modal
    Contact Should Not Be Visible    ${EMPTY}    0912645678

Verify that empty of contact should not be able to be created
    Create Contact    ${EMPTY}    ${EMPTY}
    Click Cancel Button On Contact Modal
    Contact Should Not Be Visible    ${EMPTY}    ${EMPTY}