# Relatório de Bugs - Cinema App

## Introdução

Este documento apresenta um resumo dos principais bugs identificados durante os testes do sistema Cinema App. Para informações mais detalhadas sobre cada bug, incluindo evidências e logs, consulte as **Issues no GitHub** do projeto. 

---

## Título: [Bug Visual] Sobreposição de texto no campo de input do endpoint da API

### **Ambiente:**

- **Página:** API Debug Tool
- **Navegador:** [Ex: Chrome v118, Firefox v117, etc.]
- **Sistema Operacional:** [Ex: Windows 11, macOS Sonoma, etc.]

### **Severidade:**

Média (Afeta a usabilidade, pois o usuário não consegue ver o que está digitando)

### **Passos para Reproduzir:**

1. Acessar a ferramenta "API Debug Tool".
2. Localizar o campo de texto destinado ao endpoint da API (ao lado do dropdown "POST").
3. Começar a digitar qualquer texto dentro do campo (ex: "/api/endpoint").
4. Observar o campo enquanto digita.

**Comportamento Atual (O que acontece):**
O texto digitado pelo usuário (`/api/endpoint`) e o texto do *placeholder* (ex: `/api/v1/point`) são exibidos ao mesmo tempo, um sobreposto ao outro. Isso torna o conteúdo do campo completamente ilegível.

**Comportamento Esperado (O que deveria acontecer):**
Assim que o usuário clica no campo e começa a digitar o primeiro caractere, o texto do *placeholder* deve desaparecer, exibindo *apenas* o texto que o usuário está inserindo.


## **Título:** [Bug] Falha ao carregar lista de "Filmes em Cartaz" na página de filmes

### **Ambiente:**

- **Página:** Filmes em Cartaz (`/movies`)
- **URL:** `http://localhost:3002/movies`
- **API (suposta):** `http://localhost:3000/api/v1`

### **Severidade:**

Alta / Crítica (Impede a funcionalidade principal da página)

### **Passos para Reproduzir:**

1. Iniciar os servidores do frontend (projeto `cinema-app`) e do backend (API).
2. No navegador, acessar a página "Filmes em Cartaz" (URL: `http://localhost:3002/movies`).
3. Observar o carregamento da página.

### **Comportamento Atual (O que acontece):**

1. A página não consegue buscar os dados dos filmes.
2. Duas (2) notificações de erro idênticas são exibidas no canto superior direito com a mensagem: "Não foi possível carregar os filmes."
3. O corpo da página exibe a mensagem de estado vazio: "Nenhum filme encontrado para os filtros selecionados."

### **Comportamento Esperado (O que deveria acontecer):**

1. A página deve se conectar à API com sucesso e buscar a lista de filmes.
2. Os cards dos filmes em cartaz devem ser exibidos no corpo da página.
3. Nenhuma notificação de erro deve ser mostrada.

### **Notas Adicionais / Possíveis Causas:**

- **API Offline:** O servidor da API (`localhost:3000`) pode não estar rodando ou pode ter caído.
- **Erro de API:** O endpoint `/api/v1/movies` (ou similar) pode estar retornando um erro 500 (Erro de Servidor) ou 404 (Não Encontrado).
- **Erro de CORS:** O backend pode não estar configurado para aceitar requisições vindas do `localhost:3002`.
- **Bug Secundário:** O fato de *duas* mensagens de erro idênticas aparecerem sugere que a lógica de tratamento de erro no frontend pode estar sendo disparada duas vezes (ex: em dois `useEffect` ou `catch` diferentes).

## Título: [Bug API] Rota POST /api/v1/sessions não encontrada (Erro 404)

### **Ambiente:**

- API Backend: `http://localhost:3000/api/v1`
- Arquivo de Teste: `testes/api/02_movies_api.robot`
- Test Case: `CT-SESSION-001.0 - Create New Session Successfully`

### **Severidade:**

Alta (Impede a criação de novas sessões, uma funcionalidade central do sistema)

**Passos para Reproduzir:**

1. Garantir que o servidor da API (backend) esteja rodando em `localhost:3000`.
2. Garantir que um usuário admin válido (`admin@example.com`) exista no banco de dados.
3. Executar os testes de API com o comando: `robot -d results testes/api/02_movies_api.robot`.
4. Observar o resultado do teste `CT-SESSION-001.0`.

### **Comportamento Atual (O que acontece):**

- O teste consegue fazer o login como administrador (o erro `401` anterior foi resolvido) e obtém um token de autenticação com sucesso.
- Imediatamente após o login, o teste tenta criar uma nova sessão enviando uma requisição `POST` para `http://localhost:3000/api/v1/sessions`.
- O servidor da API responde com um erro `404 Not Found`.
- O teste falha com a mensagem: `HTTPError: 404 Client Error: Not Found for url: http://localhost:3000/api/v1/sessions`.

### **Comportamento Esperado (O que deveria acontecer):**

- A API deve ter uma rota de `POST` definida em `/api/v1/sessions` que aceite um token de admin e um corpo JSON para criar uma sessão.
- O servidor deve aceitar a requisição e criar a nova sessão no banco de dados.
- A API deve retornar um status `201 Created` e os dados da sessão criada.
- O teste `CT-SESSION-001.0` deve passar.

## **Título:** [Bug Visual] Imagem do pôster do filme não é exibida na listagem

### **Ambiente:**

- **Página:** Filmes em Cartaz (`/movies`)
- **URL:** `http://localhost:3002/movies`

### **Severidade:**

Média (Afeta significativamente a experiência do usuário e a interface, mas não impede a funcionalidade principal)

### **Passos para Reproduzir:**

1. Garantir que os servidores do frontend e backend estejam rodando.
2. Acessar a página "Filmes em Cartaz" (`http://localhost:3002/movies`).
3. Observar os cards dos filmes.

### **Comportamento Atual (O que acontece):**

- Os cards dos filmes (ex: "The Avengers", "Inception") são exibidos corretamente.
- Os dados de texto (título, duração, classificação) são carregados.
- A imagem principal do pôster de cada filme está quebrada.
- Em vez do pôster, a interface exibe uma imagem de fallback (placeholder) com um ícone de silhueta e o texto "Imagem indisponível".

### **Comportamento Esperado (O que deveria acontecer):**

- O pôster oficial de cada filme deve ser carregado e exibido corretamente dentro do seu respectivo card.

## **Título:** [Bug API] Rota `POST /auth/register` falha com Erro 500 (Internal Server Error) ao enviar JSON válido

### **Severidade:**

Crítica (Impede totalmente o registro de novos usuários)

### **Ambiente:**

- API: `{{baseURL}}`
- Endpoint: `POST /auth/register`

### **Passos para Reproduzir:**

1. Abrir o Postman (ou qualquer cliente de API).
2. Criar uma requisição `POST` para `{{baseURL}}/auth/register`.
3. Definir o `Content-Type` do header como `application/json`.
4. Enviar um corpo (Body) JSON válido, como:JSON
    
    `{
      "name": "Test User",
      "email": "test@example.com",
      "password": "password123"
    }`
    
5. Clicar em "Send".

### **Comportamento Atual (O que acontece):**

- A API responde com um status `500 Internal Server Error`.
- O corpo da resposta é um JSON de erro contendo um *stack trace* do servidor.
- Mensagem de erro: `"TypeError: Cannot destructure property 'name' of 'req.body' as it is undefined."`

### **Comportamento Esperado (O que deveria acontecer):**

- A API deve processar o JSON de entrada com sucesso.
- Um novo usuário deve ser criado no banco de dados.
- A API deve responder com um status `201 Created` e os dados do usuário criado (incluindo um token de autenticação).

## **Título:** [Bug API] Mensagem de erro incorreta ao tentar registrar com o campo 'name' vazio

### **Severidade:**

Média (A API impede o cadastro, o que é bom, mas retorna uma mensagem de erro completamente enganosa, o que aponta para uma falha na lógica de validação)

### **Ambiente:**

- **Endpoint:** `POST /auth/register`
- **Requisição:** "Cadastro em branco"

### **Passos para Reproduzir:**

1. Garantir que um usuário com o email da variável (`{{newUserEmail}}`) já exista no banco de dados (provavelmente de um teste anterior).
2. No Postman, enviar uma requisição `POST` para `{{baseURL}}/auth/register`.
3. No "Body" (JSON), enviar um `name` como string vazia (`""`) e um `email` que já exista no sistema:JSON
    
    `{
      "name": "",
      "email": "{{newUserEmail}}",
      "password": "{{newUserPassword}}"
    }`
    
4. Observar a resposta da API.

### **Comportamento Atual (O que acontece):**

- O servidor responde com `400 Bad Request`.
- A mensagem de erro retornada é `{"success": false, "message": "User already exists"}`.

### **Comportamento Esperado (O que deveria acontecer):**

- A API deve **primeiro** validar se todos os campos obrigatórios estão preenchidos.
- Ao detectar que o `name` está em branco, ela deve **imediatamente** retornar um erro `400 Bad Request` com uma mensagem de validação específica.
- A resposta esperada seria: `{"success": false, "message": "O campo 'name' é obrigatório."}` (ou algo similar).
- A API **não** deveria nem chegar a verificar se o email existe, pois a validação básica dos campos falhou primeiro.

## **Título:** [Bug Visual] Sobreposição do texto (placeholder) sobre o ícone nos campos de E-mail e Senha

### **Ambiente:**

- **Página:** Login
- **URL:** `http://localhost:3002/login`

### **Severidade:**

Baixa (É um problema puramente visual que afeta a estética, mas não impede o usuário de fazer login)

### **Passos para Reproduzir:**

1. Acessar a página de Login (`/login`).
2. Observar os campos "E-mail" e "Senha" antes de digitar.

### **Comportamento Atual (O que acontece):**

- O texto do placeholder (ex: "seu e-mail" e "a senha") está posicionado diretamente em cima dos ícones (ícone de usuário e ícone de cadeado) dentro dos campos de input.
- Isso torna a interface visualmente "quebrada" e os ícones difíceis de ver.

### **Comportamento Esperado (O que deveria acontecer):**

- O texto do placeholder deve começar *ao lado* (à direita) do ícone, não em cima dele.
- Deve haver um `padding` (preenchimento à esquerda) aplicado ao texto do input (e ao placeholder) para que ele não se sobreponha ao ícone.

## **Título:** [Bug Funcional] Aba "Minhas Reservas" na página de Perfil não funciona ao ser clicada

### **Ambiente:**

- **Página:** Perfil do Usuário
- **URL:** `http://localhost:3002/profile`

**Severidade:** Alta (Impede o usuário de acessar uma funcionalidade principal da sua conta: ver suas reservas)

### **Passos para Reproduzir:**

1. Fazer login na aplicação com um usuário (ex: ana@example.com).
2. Navegar até a página de "Perfil" (URL: `/profile`).
3. A página carrega e exibe a aba "Meu Perfil" por padrão.
4. Clicar na aba "Minhas Reservas" (ao lado de "Meu Perfil").

### **Comportamento Atual (O que acontece):**

- Nada acontece. O clique na aba "Minhas Reservas" não tem efeito.
- A página continua exibindo o conteúdo da aba "Meu Perfil" (a seção "Informações Pessoais").
- O foco visual (a aba selecionada) não muda de "Meu Perfil" para "Minhas Reservas".

### **Comportamento Esperado (O que deveria acontecer):**

- Ao clicar na aba "Minhas Reservas", o conteúdo da página deve ser atualizado para exibir a lista de reservas do usuário.
- A aba "Minhas Reservas" deve se tornar visualmente ativa (selecionada), e a aba "Meu Perfil" deve ficar inativa.

### **Notas Adicionais / Causa Provável:**

- Este é um bug de frontend. A causa provável é que falta um `onClick` event handler na aba "Minhas Reservas".
- Também pode ser um erro no gerenciamento de estado (ex: `useState` no React) que não está atualizando qual aba deve ser exibida.

## **Título:** [Bug de Validação] Campo "Nome Completo" aceita um ponto (`.`) como um nome de usuário válido

### **Ambiente:**

- **Página:** Perfil do Usuário
- **URL:** `http://localhost:3002/profile`
- **API (Suposta):** `POST /auth/register` ou `PUT /profile`

### **Severidade:**

Alta (Isso leva à corrupção de dados "sujos" no banco de dados e apresenta uma péssima experiência ao usuário.)

### **Passos para Reproduzir:**

1. Navegar até a página de "Cadastro" (ou, se a edição de perfil estiver funcionando, ir para "Meu Perfil").
2. No campo "Nome Completo", digitar apenas um caractere de ponto (`.`).
3. Preencher os outros campos (email, senha) com dados válidos.
4. Submeter o formulário (clicar em "Cadastrar" ou "Salvar").
5. Fazer login e navegar até a página de "Perfil".

### **Comportamento Atual (O que acontece):**

- O sistema (API) aceita o `.` como um "Nome Completo" válido e o salva no banco de dados.
- O frontend exibe o `.` no perfil do usuário, como mostrado na imagem.

### **Comportamento Esperado (O que deveria acontecer):**

- O backend (API) deve ter regras de validação estritas para o campo `name`.
- A API deve rejeitar nomes que não atendam aos critérios mínimos (ex: "O nome deve ter pelo menos 3 caracteres", "O nome não pode conter apenas pontuação").
- O frontend deve exibir uma mensagem de erro clara para o usuário (ex: "Nome completo inválido") e impedir o envio do formulário.

## **Título:** [Bug API] `POST /reservations` retorna "Resource not found" (400) ao enviar um ID de sessão mal formatado

### **Comportamento Atual:**

- Quando um `sessionId` mal formatado (ex: a palavra "string") é enviado no corpo, a API falha ao tentar convertê-lo para um ObjectId (um `CastError`).
- O servidor responde com `400 Bad Request` e a mensagem genérica `{"success": false, "message": "Resource not found"}`.

### **Comportamento Esperado:**

- A API deve validar o formato do `sessionId` antes de consultar o banco.
- Ela deve retornar um erro `400 Bad Request` com uma mensagem clara, como: `{"success": false, "message": "O ID da sessão fornecido é inválido."}`.

## **Título:** [Bug Frontend] Rota de "Administração" não encontrada (Erro 404)

### **Ambiente:**

- **Página:** Administração
- **URL:** `http://localhost:3002/admin`
- **Tipo de Usuário:** Administrador

### **Severidade:**

Crítica (Impede o administrador de acessar *todas* as funcionalidades de gerenciamento do site)

### **Passos para Reproduzir:**

1. Fazer login na aplicação com um usuário que tenha a *role* (função) de "admin".
2. Verificar se o link "Administração" aparece na barra de navegação principal.
3. Clicar no link "Administração".

### **Comportamento Atual (O que acontece):**

- O frontend (React/Angular/Vue) tenta navegar para a URL `/admin`.
- O roteador do frontend não encontra uma página ou componente associado a essa rota.
- O usuário é redirecionado para a página "404 Página Não Encontrada".

### **Comportamento Esperado (O que deveria acontecer):**

- Ao clicar em "Administração", o usuário deve ser levado para a página ou *dashboard* de administração.
- A página de administração (ex: gerenciamento de filmes, sessões, usuários) deve ser exibida.

### **Notas Adicionais / Causa Provável:**

- Este é um bug 100% no **frontend**.
- A causa provável é que o componente da página de Admin não foi criado, ou (mais provável) a rota `/admin` não foi definida no arquivo de rotas principal do projeto (ex: `App.js` ou `index.js`).

## **Título:** [Bug de Integridade de Dados] Reservas continuam existindo após o "Cinema" (Theater) associado ser deletado

### **Severidade:**

Crítica (Isso causa inconsistência de dados no banco de dados, o que pode levar a erros graves em relatórios, reembolsos e na experiência do usuário)

### **Ambiente:**

- **Página:** Minhas Reservas (`/reservations`)
- **Entidades do DB:** `Reservations`, `Sessions`, `Theaters`

### **Passos para Reproduzir:**

1. **CRIAR DADOS:**
    - 1.1. Criar um novo Cinema (ex: "Theater X") e salvar seu `theater_id`.
    - 1.2. Criar uma nova Sessão (ex: "Sessão Y") usando o `theater_id` e um `movie_id` válido. Salvar seu `session_id`.
    - 1.3. Como um usuário logado, criar uma nova Reserva para a "Sessão Y".
2. **VERIFICAR SUCESSO:**
    - 2.1. Navegar até a página "Minhas Reservas" (`/reservations`).
    - 2.2. Confirmar que a reserva para a "Sessão Y" está visível (como na imagem).
3. **AÇÃO (O BUG):**
    - 3.1. Ir diretamente ao banco de dados (MongoDB Compass, etc.) ou usar uma rota de API (se existir) para **deletar permanentemente** o "Theater X".
4. **OBSERVAR O RESULTADO:**
    - 4.1. Recarregar a página "Minhas Reservas" (`/reservations`).

### **Comportamento Atual (O que acontece):**

- O `Theater` (Cinema) é deletado com sucesso do banco de dados.
- As `Session`s e `Reservation`s associadas a ele **NÃO** são deletadas e permanecem no banco de dados.
- A página "Minhas Reservas" continua exibindo a reserva, mas ela está "quebrada" (ex: o pôster do filme não carrega), pois seus dados de referência (o cinema) não existem mais.

### **Comportamento Esperado (O que deveria acontecer):**
A API deveria ter uma regra de negócio para lidar com isso. Uma destas três opções:

- **Opção 1 (Recomendada - Bloquear Deleção):** A API deveria **impedir** a deleção do "Theater X", retornando um erro `409 Conflict` (ex: "Não é possível deletar este cinema, pois ele possui sessões ativas.").
- **Opção 2 (Deleção em Cascata):** Ao deletar o `Theater`, a API deveria automaticamente deletar em "cascata" todas as `Session`s e `Reservation`s dependentes. A reserva sumiria da lista.
- **Opção 3 (Soft Delete):** O `Theater` não seria deletado, mas sim marcado como "inativo" (`isDeleted: true`). A reserva (sendo histórica) poderia continuar na lista, mas o frontend deveria lidar com isso.

O comportamento atual (permitir a deleção e criar dados órfãos) é a pior opção e está incorreto.

## **Título:** [Bug Crítico de Integridade] Acesso a "Seleção de Assentos" de uma sessão órfã (sem cinema) quebra a página

### **Severidade:**

Crítica (Permite que o usuário acesse e tente interagir com dados inexistentes, resultando em uma página quebrada e imprevisível)

### **Ambiente:**

- **Página:** Seleção de Assentos
- **URL:** `http://localhost:3002/sessions/<session_id>`

### **Pré-condição:**

- É necessário ter uma `Sessão` "órfã" no banco de dados (criada a partir do bug de deleção do `Theater` que você encontrou anteriormente).

### **Passos para Reproduzir:**

1. Seguir os passos do bug anterior (deletar um `Theater` do banco de dados sem deletar as `Session`s associadas).
2. No frontend, fazer login como o usuário que possui uma reserva para uma dessas sessões órfãs.
3. Navegar até "Minhas Reservas".
4. Clicar na reserva órfã (ou navegar diretamente para a URL da sessão: `.../sessions/<id_da_sessao_orfa>`).

### **Comportamento Atual (O que acontece):**

- O sistema permite o acesso à página de seleção de assentos para a sessão órfã.
- A página é renderizada em um estado "quebrado", pois os dados do cinema (Theater) não existem mais.
- O nome do cinema/sala é exibido incorretamente como `"string - standard"`.
- O mapa de assentos não é carregado.

### **Comportamento Esperado (O que deveria acontecer):**

A API ou o frontend deveriam impedir isso.

- **Idealmente (Solução de Backend):** A API (ex: `GET /sessions/<id>`) deveria detectar que o `theater_id` referenciado não existe e retornar um erro `404 Not Found` (Sessão não encontrada).
- **Alternativa (Solução de Frontend):** O frontend, ao receber os dados da sessão e ver que as informações do cinema são nulas, deveria redirecionar o usuário ou exibir uma mensagem de erro clara (ex: "Esta sessão não está mais disponível").
- Tentar renderizar a página quebrada é o pior cenário.