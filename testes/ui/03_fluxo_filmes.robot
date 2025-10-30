*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/variables.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
View Movies List
    [Documentation]    CT-MOVIES-001 - Visualizar lista de filmes
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    movies_user_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Movies User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser
    
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    
    # Access movies
    Go To    ${BASE_URL}/movies
    Wait Until Element Is Visible    css=.movie-card    10s
    Element Should Be Visible    css=.movie-card
    [Teardown]    Close Browser

View Movie Details
    [Documentation]    CT-MOVIES-002 - Visualizar detalhes de um filme
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    movie_detail_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Movie Detail User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser
    
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    
    # View movie details
    Go To    ${BASE_URL}/movies/${VALID_MOVIE_ID}
    Wait Until Element Is Visible    css=body    10s
    Location Should Contain    /movies/
    [Teardown]    Close Browser

Search Movies
    [Documentation]    CT-MOVIES-003 - Buscar filmes
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    search_user_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Search User
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Input Text    css=#confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Cadastrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    Close Browser
    
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#email    5s
    Input Text    css=#email    ${email}
    Input Text    css=#password    ${PASSWORD}
    Click Button    xpath=//button[normalize-space()='Entrar']
    Wait Until Element Is Visible    css=.alert.alert-success    10s
    
    # Search movies
    Go To    ${BASE_URL}/movies
    Wait Until Element Is Visible    css=input    10s
    Input Text    css=input    Inception
    Press Keys    css=input    ENTER
    Wait Until Element Is Visible    css=body    5s
    [Teardown]    Close Browser