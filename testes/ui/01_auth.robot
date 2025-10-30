*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Resource          ../resources/variables.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
Register User UI Successfully
    [Documentation]    CT-AUTH-001.1 - Registrar usuário via UI (caminho feliz)
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    ui_user_${ts}@example.com
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Robot UI User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Element Should Contain    css=.alert.alert-success .alert-content    Conta criada com sucesso
    ${loc}=    Get Location
    [Teardown]    Close Browser

Login UI With Valid Credentials
    [Documentation]    CT-AUTH-002.1 - Login com credenciais válidas via UI
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    ui_login_${ts}@example.com
    # Register first (UI)
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Login UI User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser

    # Now login
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Element Should Contain    css=.alert.alert-success .alert-content    Login realizado com sucesso
    [Teardown]    Close Browser

