*** Variables ***
${VALID_MOVIE_ID}    69025fc9b6e811e31ffd34ba    # ID do filme Inception
${INVALID_MOVIE_ID}    999999
${MOVIES_ENDPOINT}    /api/v1/movies
${SESSIONS_ENDPOINT}    /api/v1/sessions
${AUTH_ENDPOINT}     /api/v1/auth
${API_URL}        http://localhost:3000    # Assuming backend runs on port 3000
${API_PATH}       /api/v1
&{ADMIN_USER}     email=admin@example.com     password=admin123
&{NEW_SESSION}    movieId=${VALID_MOVIE_ID}    
...              date=2023-11-01    
...              time=14:30    
...              theater=Sala 1    
...              price=25.00
