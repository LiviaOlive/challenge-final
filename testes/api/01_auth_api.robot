*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         BuiltIn

Suite Setup     Create Session    api    ${BASE_URL}
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       http://localhost:3000/api/v1

# How to run: from project root
#   robot -d results testes/api/01_auth_api.robot

*** Test Cases ***
Registrar User Com Sucesso
    [Documentation]    CT-AUTH-001.1 - Registrar usuário via API (caminho feliz)
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    user_${ts}@example.com
    ${payload}=    Create Dictionary    name=Robot Test User    email=${email}    password=Senha@123
    
    ${response}=    POST On Session    api    /auth/register    json=${payload}
    
    Should Be Equal As Integers    ${response.status_code}    201
    ${resp_text}=    Convert To String    ${response.content}
    Log    ${resp_text}
    Should Contain    ${resp_text}    ${email}
    Should Contain    ${resp_text}    token

Login Com Credenciais Validas
    [Documentation]    CT-AUTH-002.1 - Login com credenciais válidas (API)
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    login_user_${ts}@example.com
    ${password}=    Set Variable    Senha@123
    ${payload_reg}=    Create Dictionary    name=Login User    email=${email}    password=${password}
    
    ${resp_reg}=    POST On Session    api    /auth/register    json=${payload_reg}
    
    Should Be Equal As Integers    ${resp_reg.status_code}    201
    
    ${payload_login}=    Create Dictionary    email=${email}    password=${password}

    ${response}=    POST On Session    api    /auth/login    json=${payload_login}
    
    Should Be Equal As Integers    ${response.status_code}    200
    ${resp_text}=    Convert To String    ${response.content}
    Log    ${resp_text}
    Should Contain    ${resp_text}    ${email}
    Should Contain    ${resp_text}    token

Login Com Senha Incorreta
    [Documentation]    CT-AUTH-002.3 - Tentar login com senha incorreta
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    wrongpw_user_${ts}@example.com
    ${password}=    Set Variable    Senha@123
    ${payload_reg}=    Create Dictionary    name=WrongPW User    email=${email}    password=${password}
    
    ${resp_reg}=    POST On Session    api    /auth/register    json=${payload_reg}
    Should Be Equal As Integers    ${resp_reg.status_code}    201
    
    ${payload_login}=    Create Dictionary    email=${email}    password=senha_errada
    
    ${response}=    POST On Session    api    /auth/login    json=${payload_login}    expected_status=401
    
    Should Be Equal As Integers    ${response.status_code}    401
    ${resp_text}=    Convert To String    ${response.content}
    Log    ${resp_text}
    Should Contain    ${resp_text}    message
