*** Settings ***
Documentation     Palavras-chave comuns para testes de API
Resource          ../resources/variables.robot
Library           RequestsLibrary
Library           Collections


*** Keywords ***
Create API Session
    Create Session    cinema    ${API_URL}    verify=True
    Set Suite Variable    ${API_PATH}    /api/v1

Check Required Movie Fields
    [Arguments]    ${movie}
    [Documentation]    Verifica se um filme contém todos os campos obrigatórios
    Dictionary Should Contain Key    ${movie}    _id    Movie should have an ID
    Dictionary Should Contain Key    ${movie}    title    Movie should have a title
    Dictionary Should Contain Key    ${movie}    synopsis    Movie should have a synopsis
    Dictionary Should Contain Key    ${movie}    classification    Movie should have a classification
    Dictionary Should Contain Key    ${movie}    duration    Movie should have a duration
    Dictionary Should Contain Key    ${movie}    releaseDate    Movie should have a release date

Validate First Session
    [Arguments]    ${session}
    Dictionary Should Contain Key    ${session}    _id    Session should have an ID
    Dictionary Should Contain Key    ${session}    date    Session should have a date
    Dictionary Should Contain Key    ${session}    time    Session should have a time
    Dictionary Should Contain Key    ${session}    theater    Session should have a theater

# --- KEYWORD ADICIONADA ---
Login As Admin
    [Documentation]    Faz login como administrador e retorna o token
    ${headers}=    Create Dictionary    Content-Type=application/json
    
    # Esta keyword agora usa as variáveis deste arquivo
    ${response}=    POST On Session    cinema    ${AUTH_ENDPOINT}/login    json=${ADMIN_USER}    headers=${headers}
    
    Status Should Be    200    ${response}
    ${token}=    Set Variable    ${response.json()}[token]
    
    # --- SINTAXE CORRIGIDA ---
    RETURN    ${token}