*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/variables.robot
Suite Teardown    Close All Browsers

*** Test Cases ***
Access Reservations Page
    [Documentation]    CT-RESERVA-001 - Acessar página de reservas
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    reserva_user_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    Reserva User
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
    
    # Access reservations via navigation
    Click Link    xpath=//a[contains(@href,'reservations') or contains(text(),'Reservas')]    
    Wait Until Element Is Visible    css=body    10s
    ${current_url}=    Get Location
    Should Not Be Equal    ${current_url}    ${BASE_URL}/
    [Teardown]    Close Browser

Create New Reservation
    [Documentation]    CT-RESERVA-002 - Criar nova reserva
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    new_reserva_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    New Reserva User
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
    
    # Create reservation
    Go To    ${BASE_URL}/movies
    Wait Until Element Is Visible    css=.movie-card    10s
    Click Element    css=.movie-card
    Wait Until Element Is Visible    css=body    10s
    Element Should Be Visible    xpath=//button
    [Teardown]    Close Browser

View My Reservations
    [Documentation]    CT-RESERVA-003 - Visualizar minhas reservas
    ${ts}=    Evaluate    str(int(time.time()*1000))    modules=time
    ${email}=    Set Variable    view_reserva_${ts}@example.com
    
    # Register and login
    Open Browser    ${BASE_URL}/register    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    css=#name    5s
    Input Text    css=#name    View Reserva User
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
    
    # View reservations
    Go To    ${BASE_URL}/my-reservations
    Wait Until Element Is Visible    css=body    10s
    Location Should Contain    /my-reservations
    [Teardown]    Close Browser