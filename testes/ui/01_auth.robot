*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn

Suite Teardown    Close All Browsers

*** Variables ***
${BASE_URL}       http://localhost:5173
${BROWSER}        chrome
${PASSWORD}       Password123!

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
    Should Contain    ${loc}    /login
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

Login UI With Incorrect Password
    [Documentation]    CT-AUTH-002.3 - Tentar login com senha incorreta via UI
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    ui_wrongpw_${ts}@example.com
    # Register user first
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    WrongPW UI User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser

    # Attempt login with wrong password
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    wrong_password
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-error    10s
    Element Should Be Visible    css=.alert.alert-error
    [Teardown]    Close Browser
