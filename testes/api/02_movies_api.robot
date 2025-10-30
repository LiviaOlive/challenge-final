*** Settings ***
Documentation     Test suite for Movies API endpoints
...               Covers US-MOVIE-001 and US-MOVIE-002 scenarios

Resource          ../resources/variables.robot
Resource          ../resources/keywords.robot
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem

Suite Setup       keywords.Create API Session


*** Test Cases ***
CT-MOVIE-001.1 - Get Movies List Successfully
    [Documentation]    Validates that the GET /movies endpoint returns a list of movies
    [Tags]    movies    smoke    
    ${response}=    GET On Session    cinema    ${MOVIES_ENDPOINT}
    Status Should Be    200    ${response}
    
    # Get response content and log it
    ${response_json}=    Set Variable    ${response.json()}
    Log    Response content: ${response_json}
    
    # Extract movies from response
    Dictionary Should Contain Key    ${response_json}    success    Response should have success field
    Dictionary Should Contain Key    ${response_json}    data    Response should have data field
    
    # Get movies list
    ${movies}=    Set Variable    ${response_json}[data]
    ${is_list}=    Evaluate    isinstance($movies, list)
    Should Be True    ${is_list}    Movies data should be a list
    Should Not Be Empty    ${movies}    Movies list should not be empty
    
    # Get and validate first movie
    ${first_movie}=    Set Variable    ${movies}[0]
    Log    First movie content: ${first_movie}
    ${keys}=    Get Dictionary Keys    ${first_movie}
    Log    Movie fields available: ${keys}
    
    # Validate movie structure
    Check Required Movie Fields    ${first_movie}

CT-MOVIE-002.1 - Get Movie Details Successfully
    [Documentation]    Validates that the GET /movies/{id} endpoint returns correct movie details
    [Tags]    movies    
    
    ${response}=    GET On Session    cinema    ${MOVIES_ENDPOINT}/${VALID_MOVIE_ID}
    Status Should Be    200    ${response}
    
    # Get response content and log it
    ${response_json}=    Set Variable    ${response.json()}
    Log    Movie details response: ${response_json}
    
    # Extract movie from response
    Dictionary Should Contain Key    ${response_json}    success    Response should have success field
    Dictionary Should Contain Key    ${response_json}    data    Response should have data field
    
    ${movie}=    Set Variable    ${response_json}[data]
    
    # Validate movie structure
    Check Required Movie Fields    ${movie}
    
    # Additional fields for detailed view
    Dictionary Should Contain Key    ${movie}    director    Movie should have a director
    Dictionary Should Contain Key    ${movie}    genres    Movie should have genres

CT-MOVIE-002.4 - Get Non-Existent Movie Details
    [Documentation]    Validates error handling when requesting a non-existent movie
    [Tags]    movies    negative
    
    ${response}=    GET On Session    cinema    ${MOVIES_ENDPOINT}/${INVALID_MOVIE_ID}
    ...    expected_status=404
    Status Should Be    404    ${response}

*** Keywords ***
*** Test Cases ***
CT-SESSION-001.0 - Create New Session Successfully
    [Documentation]    Creates a new session for a movie
    [Tags]    movies    sessions    create
    
    # Fazer login primeiro e obter o token
    ${token}=    Login As Admin
    ${headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Authorization=Bearer ${token}
    
    ${response}=    POST On Session    cinema    ${SESSIONS_ENDPOINT}    
    ...    json=${NEW_SESSION}    
    ...    headers=${headers}
    Status Should Be    201    ${response}
    
    # Validate response
    ${response_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${response_json}    success
    Dictionary Should Contain Key    ${response_json}    data
    
    # Store session ID for future tests
    ${session}=    Set Variable    ${response_json}[data]
    Set Suite Variable    ${CREATED_SESSION_ID}    ${session}[_id]

CT-SESSION-001.1 - Get Sessions List Successfully
    [Documentation]    Validates that the GET /sessions endpoint returns a list of sessions
    [Tags]    movies    sessions
    
    ${response}=    GET On Session    cinema    /api/v1/sessions
    Status Should Be    200    ${response}
    
    # Get response content
    ${response_json}=    Set Variable    ${response.json()}
    Log    Sessions response: ${response_json}
    
    # Validate response structure
    Dictionary Should Contain Key    ${response_json}    success    Response should have success field
    Should Be Equal    ${response_json}[success]    ${True}
    Dictionary Should Contain Key    ${response_json}    data    Response should have data field
    
    ${sessions}=    Set Variable    ${response_json}[data]
    
    # Validate it's a list (even if empty)
    ${is_list}=    Evaluate    isinstance($sessions, list)
    Should Be True    ${is_list}    Response should be a list of sessions