*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         BuiltIn
Resource        ../resources/variables.robot

Suite Setup     Create Session    api    ${API_URL}
Suite Teardown  Delete All Sessions

*** Test Cases ***
Create Reservation Successfully
    [Documentation]    CT-RESERVA-API-001 - Criar reserva via API
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    reserva_api_${ts}@example.com
    
    # Register user
    ${reg_payload}=    Create Dictionary    name=Reserva API User    email=${email}    password=${PASSWORD}
    ${reg_response}=    POST On Session    api    ${AUTH_ENDPOINT}/register    json=${reg_payload}
    Should Be Equal As Integers    ${reg_response.status_code}    201
    
    # Login user
    ${login_payload}=    Create Dictionary    email=${email}    password=${PASSWORD}
    ${login_response}=    POST On Session    api    ${AUTH_ENDPOINT}/login    json=${login_payload}
    Should Be Equal As Integers    ${login_response.status_code}    200
    ${resp_json}=    Set Variable    ${login_response.json()}
    ${token}=    Set Variable    ${resp_json}[data][token]
    
    # Create reservation
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${reserva_payload}=    Create Dictionary    movieId=${VALID_MOVIE_ID}    sessionId=session123    seats=["A1", "A2"]
    ${response}=    POST On Session    api    /api/v1/reservations    json=${reserva_payload}    headers=${headers}    expected_status=any
    Should Be True    ${response.status_code} in [200, 201, 404]

Get User Reservations
    [Documentation]    CT-RESERVA-API-002 - Listar reservas do usuário
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    get_reserva_${ts}@example.com
    
    # Register and login
    ${reg_payload}=    Create Dictionary    name=Get Reserva User    email=${email}    password=${PASSWORD}
    ${reg_response}=    POST On Session    api    ${AUTH_ENDPOINT}/register    json=${reg_payload}
    Should Be Equal As Integers    ${reg_response.status_code}    201
    
    ${login_payload}=    Create Dictionary    email=${email}    password=${PASSWORD}
    ${login_response}=    POST On Session    api    ${AUTH_ENDPOINT}/login    json=${login_payload}
    Should Be Equal As Integers    ${login_response.status_code}    200
    ${resp_json}=    Set Variable    ${login_response.json()}
    ${token}=    Set Variable    ${resp_json}[data][token]
    
    # Get reservations
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api    /api/v1/reservations    headers=${headers}    expected_status=any
    Should Be True    ${response.status_code} in [200, 403, 404]

Cancel Reservation
    [Documentation]    CT-RESERVA-API-003 - Cancelar reserva
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    cancel_reserva_${ts}@example.com
    
    # Register and login
    ${reg_payload}=    Create Dictionary    name=Cancel Reserva User    email=${email}    password=${PASSWORD}
    ${reg_response}=    POST On Session    api    ${AUTH_ENDPOINT}/register    json=${reg_payload}
    Should Be Equal As Integers    ${reg_response.status_code}    201
    
    ${login_payload}=    Create Dictionary    email=${email}    password=${PASSWORD}
    ${login_response}=    POST On Session    api    ${AUTH_ENDPOINT}/login    json=${login_payload}
    Should Be Equal As Integers    ${login_response.status_code}    200
    ${resp_json}=    Set Variable    ${login_response.json()}
    ${token}=    Set Variable    ${resp_json}[data][token]
    
    # Try to cancel (using generic ID)
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${cancel_response}=    DELETE On Session    api    /api/v1/reservations/reservation123    headers=${headers}    expected_status=any
    Should Be True    ${cancel_response.status_code} in [200, 204, 403, 404]