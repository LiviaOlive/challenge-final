*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           BuiltIn

Suite Setup       Create Session    api    ${BASE_URL}
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       http://localhost:3000/api/v1

# How to run: from project root
#   robot -d results testes/api/01_auth_api.robot

*** Test Cases ***
Register User Successfully
	[Documentation]    CT-AUTH-001.1 - Registrar usuário via API (caminho feliz)
	${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
	${email}=    Set Variable    user_${ts}@example.com
	${payload}=    Create Dictionary    name=Robot Test User    email=${email}    password=Senha@123
	${response}=    Post Request    api    /auth/register    json=${payload}
	Should Be Equal As Integers    ${response.status_code}    201
	${body}=    Evaluate    response.json()    response=${response}
	Should Be True    ${body['success']}
	Should Contain    ${body['data']['email']}    ${email}
	Should Not Be Empty    ${body['data']['token']}

Login With Valid Credentials
	[Documentation]    CT-AUTH-002.1 - Login com credenciais válidas (API)
	${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
	${email}=    Set Variable    login_user_${ts}@example.com
	${password}=    Set Variable    Senha@123
	${payload_reg}=    Create Dictionary    name=Login User    email=${email}    password=${password}
	${resp_reg}=    Post Request    api    /auth/register    json=${payload_reg}
	Should Be Equal As Integers    ${resp_reg.status_code}    201
	${payload_login}=    Create Dictionary    email=${email}    password=${password}
	${response}=    Post Request    api    /auth/login    json=${payload_login}
	Should Be Equal As Integers    ${response.status_code}    200
	${body}=    Evaluate    response.json()    response=${response}
	Should Be True    ${body['success']}
	Should Contain    ${body['data']['email']}    ${email}
	Should Not Be Empty    ${body['data']['token']}

Login With Incorrect Password
	[Documentation]    CT-AUTH-002.3 - Tentar login com senha incorreta
	${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
	${email}=    Set Variable    wrongpw_user_${ts}@example.com
	${password}=    Set Variable    Senha@123
	${payload_reg}=    Create Dictionary    name=WrongPW User    email=${email}    password=${password}
	${resp_reg}=    Post Request    api    /auth/register    json=${payload_reg}
	Should Be Equal As Integers    ${resp_reg.status_code}    201
	${payload_login}=    Create Dictionary    email=${email}    password=senha_errada
	${response}=    Post Request    api    /auth/login    json=${payload_login}
	Should Be Equal As Integers    ${response.status_code}    400
	${body}=    Evaluate    response.json()    response=${response}
	Dictionary Should Contain Key    ${body}    message
	Should Contain    ${body['message']}    Invalid

