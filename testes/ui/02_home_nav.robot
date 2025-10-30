*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/variables.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
Access Home Page Without Login
    [Documentation]    CT-HOME-001 - Acessar página inicial sem login
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=body    5s
    Title Should Be    Cinema App
    [Teardown]    Close Browser

Navigate To Login From Home
    [Documentation]    CT-HOME-002 - Navegar para login a partir da home
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=a[href="/login"]    5s
    Click Link    css=a[href="/login"]
    Wait Until Location Contains    /login
    Title Should Be    Cinema App
    [Teardown]    Close Browser

Navigate To Register From Home
    [Documentation]    CT-HOME-003 - Navegar para registro a partir da home
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=a[href="/register"]    5s
    Click Link    css=a[href="/register"]
    Wait Until Location Contains    /register
    Title Should Be    Cinema App
    [Teardown]    Close Browser

Access Home After Login
    [Documentation]    CT-HOME-004 - Acessar home após login
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    home_user_${ts}@example.com
    
    # Register user
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Home Test User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser
    
    # Login and access home
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    css=body    5s
    Title Should Be    Cinema App
    [Teardown]    Close Browser