# Plano de Testes - Cinema App

## 1. Introdução

### 1.1. Objetivo
Este documento define a estratégia e o planejamento dos testes de Qualidade (QA) para a aplicação "Cinema App". O objetivo é validar se todas as funcionalidades implementadas atendem aos Critérios de Aceitação (AC) definidos nas Histórias de Usuário (US), garantindo um produto estável, funcional e com boa experiência de usuário.

### 1.2. Documentos de Referência
* Histórias de Usuário do Cinema App (documento fornecido)
* Documentação da API

## 2. Escopo do Teste

### 2.1. Em Escopo
As seguintes funcionalidades e módulos serão testados:

* **Autenticação:** Registro (US-AUTH-001), Login (US-AUTH-002), Logout (US-AUTH-003).
* **Gerenciamento de Perfil:** Visualização e atualização de perfil (US-AUTH-004).
* **Navegação Principal:** Página Inicial (US-HOME-001) e Navegação Geral (US-NAV-001).
* **Jornada de Filmes:** Listagem de filmes (US-MOVIE-001) e Detalhes do filme (US-MOVIE-002).
* **Sessões:** Visualização de horários (US-SESSION-001).
* **Jornada de Reserva (Fluxo E2E):**
    * Seleção de Assentos (US-RESERVE-001)
    * Checkout (US-RESERVE-002)
    * Histórico de Reservas (US-RESERVE-003)
* **Testes Não-Funcionais (Básicos):**
    * Responsividade (Mobile, Tablet, Desktop).
    * Usabilidade (intuitividade da navegação).

### 2.2. Fora de Escopo
As seguintes funcionalidades não serão o foco desta fase de testes:

* Painel de Administração: Criação, Edição ou Remoção de filmes, sessões, cinemas ou gerenciamento de usuários. (As US fornecidas focam na visão do cliente).
* Integração Real com Gateway de Pagamento: O teste focará na simulação do pagamento, conforme US-RESERVE-002.
* Testes de Performance e Carga: (Ex: múltiplos usuários simultâneos fazendo reservas).
* Testes de Segurança Aprofundados: (Ex: Testes de penetração, XSS, SQL Injection). O foco será na segurança funcional (rotas protegidas).

## 3. Estratégia de Teste
Adotaremos uma abordagem híbrida, combinando testes manuais para garantir a usabilidade e testes automatizados para garantir a estabilidade e regressão dos fluxos críticos.

### 3.1. Níveis de Teste
* **Testes de API (Back-end):** Validação direta dos endpoints da API (Ex: `POST /login`, `GET /movies`, `POST /reservations`). Esta será a base da automação, por ser mais rápida e estável.
* **Testes de UI (Front-end E2E):** Validação da interação do usuário com a interface, cobrindo os fluxos completos (ex: login -> selecionar filme -> reservar).
* **Testes Manuais Exploratórios:** Focados em usabilidade, responsividade e descoberta de cenários não previstos (testes "sad path").

### 3.2. Estratégia de Automação
A automação será desenvolvida seguindo as boas práticas e padrões de projeto mencionados nos critérios de avaliação.

#### Padrões de Projeto
* **UI:** PageObjects (ou AppActions, dependendo da ferramenta, ex: Cypress Custom Commands) para abstrair a interação com as páginas e componentes.
* **API:** ServiceObjects (ou API Clients) para encapsular a lógica de requisição e resposta dos endpoints.

#### Estrutura
O projeto de automação será estruturado para ser limpo, reutilizável e com cenários independentes, permitindo a execução paralela (se aplicável).

#### Manipulação de Dados
Serão utilizadas *fixtures* ou criação de dados dinâmicos (via API) para garantir que os testes não dependam de um estado fixo do banco de dados.

## 4. Ferramentas e Ambiente
* **Gerenciamento de Projeto e Defeitos:** Github (Issues, Projects, Wiki).
* **Controle de Versão:** Git / Github.
* **Automação de API** Postman (para testes manuais) e RobotFramework (para automação).
* **Navegadores:** Chrome (principal), Opera.

## 5. Entregáveis de Teste

* **Plano de Testes (este documento):** Definindo a estratégia.
* **Mapa Mental:** Um artefato visual (ex: usando Coggle, XMind) detalhando a cobertura das funcionalidades e cenários.
* **Casos de Teste (Cenários):** Descritos na seção 7 deste documento e/ou convertidos para formato Gherkin (BDD) no projeto de automação.
* **Scripts de Automação:** Código-fonte no repositório Github.
* **Relatórios de Defeitos (Issues):** Abertas no Github com labels (bug, melhoria, prioridade: alta, etc.).
* **Documentação do Projeto:** `README.md` explicando como configurar e executar a automação.

## 6. Gerenciamento de Defeitos (Issues)
* **Plataforma:** Github Issues.
* **Estrutura do Report:**
    * **Título:** Claro e conciso (Ex: "[BUG] Login falha com credenciais válidas").
    * **Descrição:** O que aconteceu.
    * **Passos para Reproduzir:**
    * **Resultado Esperado:**
    * **Resultado Atual:**
    * **Evidências:** Screenshots, vídeos (GIFs), logs do console.
    * **Ambiente:** Navegador, viewport, usuário de teste.
    * **Labels:** `bug`, `melhoria`, `front-end`, `back-end`, `prioridade:alta`, `prioridade:media`, `prioridade:baixa`.

## 7. Cenários de Teste (Alto Nível)
Esta seção detalha os cenários de teste derivados de cada História de Usuário.

### Módulo: Autenticação
#### US-AUTH-001: Registro de Usuário
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-AUTH-001.1 | Realizar registro com sucesso (caminho feliz) | O usuário está na página de registro. O e-mail de teste não existe no banco. | 1. Preencher o campo "nome" com um nome válido.<br>2. Preencher o campo "email" com um e-mail novo e válido.<br>3. Preencher o campo "senha" com uma senha forte (conforme critérios).<br>4. Clicar no botão "Registrar". | O usuário é registrado com sucesso, é redirecionado para a Home (logado) ou para a página de Login. | nome: "Usuário Teste"<br>email: "novo_usuario_[timestamp]@teste.com"<br>senha: "Senha@123" |
| CT-AUTH-001.2 | Tentar registrar com e-mail duplicado | O e-mail "existente@teste.com" já está cadastrado no banco. | 1. Preencher os campos "nome" e "senha".<br>2. Preencher o campo "email" com "existente@teste.com".<br>3. Clicar no botão "Registrar". | Uma mensagem de erro clara (ex: "Este e-mail já está em uso") é exibida. O usuário não é registrado. | email: "existente@teste.com" |
| CT-AUTH-001.3 | Tentar registrar com e-mail inválido | O usuário está na página de registro. | 1. Preencher os campos "nome" e "senha".<br>2. Preencher o campo "email" com um valor inválido.<br>3. Clicar no botão "Registrar" (ou desfocar o campo). | Uma mensagem de validação (ex: "Formato de e-mail inválido") é exibida. O formulário não é enviado. | email: "teste.com"<br>email: "teste@"<br>email: " " |
| CT-AUTH-001.4 | Tentar registrar com campos obrigatórios em branco | O usuário está na página de registro. | 1. Deixar o campo "nome" (ou "email", ou "senha") em branco.<br>2. Clicar no botão "Registrar". | Mensagens de validação são exibidas para cada campo obrigatório (ex: "Campo obrigatório"). O formulário não é enviado. | nome: "" (vazio)<br>email: "" (vazio) |
| CT-AUTH-001.5 | Tentar registrar com senha fraca | O usuário está na página de registro. | 1. Preencher "nome" e "email".<br>2. Preencher o campo "senha" com um valor que não atende aos critérios (ex: "123").<br>3. Clicar no botão "Registrar". | Uma mensagem de erro (ex: "A senha deve ter...") é exibida. | senha: "12345" |

#### US-AUTH-002: Login de Usuário
* **CT-AUTH-002.1 (Positivo):** Realizar login com credenciais válidas. (Validar redirecionamento para Home e presença de token JWT no localStorage/sessionStorage).
* **CT-AUTH-002.2 (Negativo):** Tentar login com e-mail não cadastrado. (Validar mensagem de erro).
* **CT-AUTH-002.3 (Negativo):** Tentar login com senha incorreta. (Validar mensagem de erro).
* **CT-AUTH-002.4 (Negativo):** Tentar login com campos em branco. (Validar erro).

#### US-AUTH-003: Logout de Usuário
* **CT-AUTH-003.1 (Positivo):** Realizar logout pelo menu de navegação. (Validar remoção do token e redirecionamento).
* **CT-AUTH-003.2 (Positivo):** Tentar acessar uma rota protegida (ex: `/perfil` ou `/minhas-reservas`) após o logout. (Validar redirecionamento para login).

#### US-AUTH-004: Visualizar e Gerenciar Perfil do Usuário
* **CT-AUTH-004.1 (Positivo):** Acessar a página de perfil e validar se nome, e-mail e função estão corretos.
* **CT-AUTH-004.2 (Positivo):** Editar o campo "nome" e salvar. (Validar mensagem de sucesso e persistência da alteração após recarregar a página).
* **CT-AUTH-004.3 (Positivo):** Validar que a página de perfil é separada da página de reservas.
* **CT-AUTH-004.4 (Negativo):** Tentar salvar o nome com valor em branco. (Validar erro).

### Módulo: Navegação e Home
#### US-HOME-001: Página Inicial Atrativa
* **CT-HOME-001.1 (Visual):** Validar exibição do banner principal.
* **CT-HOME-001.2 (Funcional):** Validar que a seção "Filmes em Cartaz" exibe pôsteres.
* **CT-HOME-001.3 (Navegação):** Validar que os links rápidos (se houver) e o menu principal funcionam.
* **CT-HOME-001.4 (Responsividade):** Validar o layout da Home em viewports de mobile, tablet e desktop.

#### US-NAV-001: Navegação Intuitiva
* **CT-NAV-001.1 (Positivo):** Validar que o cabeçalho está presente em todas as páginas (Home, Detalhes, Perfil, etc.).
* **CT-NAV-001.2 (Positivo):** Validar menu para usuário logado (links "Minhas Reservas", "Perfil", "Logout").
* **CT-NAV-001.3 (Positivo):** Validar menu para visitante (links "Login", "Registro").
* **CT-NAV-001.4 (Responsividade):** Validar que o menu se transforma em "hambúrguer" em telas móveis e que é funcional.
* **CT-NAV-001.5 (Visual):** Validar feedback visual da página atual no menu.

### Módulo: Filmes e Sessões
#### US-MOVIE-001: Navegar na Lista de Filmes
* **CT-MOVIE-001.1 (Visual):** Validar que os filmes são exibidos em grid com pôsteres de qualidade.
* **CT-MOVIE-001.2 (Visual):** Validar que os cards contêm: título, classificação, gêneros, duração e data de lançamento.
* **CT-MOVIE-001.3 (Funcional):** Clicar em um card de filme. (Validar redirecionamento para a página de detalhes do filme correto).
* **CT-MOVIE-001.4 (Responsividade):** Validar o layout do grid em diferentes viewports.

#### US-MOVIE-002: Visualizar Detalhes do Filme
* **CT-MOVIE-002.1 (Visual):** Validar exibição de todas as informações: sinopse, elenco, diretor, pôster, etc.
* **CT-MOVIE-002.2 (Funcional):** Validar que a seção de horários (US-SESSION-001) é exibida.
* **CT-MOVIE-002.3 (Funcional):** Clicar em um horário disponível. (Validar redirecionamento para a seleção de assentos).
* **CT-MOVIE-002.4 (Negativo):** Tentar acessar detalhes de um filme com ID inválido (ex: `/filme/9999`). (Validar tratamento de erro - ex: "Filme não encontrado" ou redirect para Home).

#### US-SESSION-001: Visualizar Horários de Sessões
* **CT-SESSION-001.1 (Visual):** Validar que os horários exibem data, hora, teatro (sala) e disponibilidade.
* **CT-SESSION-001.2 (Funcional):** Clicar em um horário. (Validar que o usuário logado é levado para a seleção de assentos).
* **CT-SESSION-001.3 (Negativo):** Clicar em um horário sendo visitante. (O sistema deve solicitar login antes de prosseguir).

### Módulo: Reservas (Fluxo E2E)
#### US-RESERVE-001: Selecionar Assentos para Reserva
* **CT-RESERVE-001.1 (Positivo):** Selecionar um assento disponível. (Validar que o assento muda de cor e o subtotal é atualizado).
* **CT-RESERVE-001.2 (Positivo):** Selecionar múltiplos assentos disponíveis. (Validar atualização do subtotal).
* **CT-RESERVE-001.3 (Positivo):** Desmarcar um assento selecionado. (Validar que o assento volta ao estado original e subtotal é atualizado).
* **CT-RESERVE-001.4 (Negativo):** Tentar selecionar um assento já reservado (ocupado). (Validar que não é clicável ou exibe aviso).
* **CT-RESERVE-001.5 (Negativo):** Tentar prosseguir para o checkout sem selecionar nenhum assento. (Validar que o botão "Continuar" está desabilitado ou exibe erro).
* **CT-RESERVE-001.6 (Visual):** Validar a legenda de cores dos assentos (disponível, ocupado, selecionado).

#### US-RESERVE-002: Processo de Checkout
* **CT-RESERVE-002.1 (Positivo):** Validar que o resumo (filme, assentos, total) está correto na página de checkout.
* **CT-RESERVE-002.2 (Positivo):** Selecionar um método de pagamento (ex: PIX).
* **CT-RESERVE-002.3 (Positivo):** Finalizar o pagamento (simulado). (Validar mensagem de sucesso e redirecionamento).
* **CT-RESERVE-002.4 (Positivo - Verificação):** Após a reserva, verificar a tela de seleção de assentos novamente para o mesmo horário. (Validar que os assentos selecionados agora aparecem como ocupados).
* **CT-RESERVE-002.5 (Negativo):** Tentar acessar a página de checkout diretamente (via URL) sem ter selecionado assentos. (Validar redirecionamento ou erro).

#### US-RESERVE-003: Visualizar Minhas Reservas
* **CT-RESERVE-003.1 (Positivo):** Acessar a página "Minhas Reservas" após realizar uma compra.
* **CT-RESERVE-003.2 (Visual):** Validar que a reserva é exibida em formato de card com todas as informações: pôster, filme, data, horário, assentos, status (confirmada) e método de pagamento.
* **CT-RESERVE-003.3 (Positivo):** Acessar "Minhas Reservas" com um usuário novo (sem reservas). (Validar exibição de mensagem amigável, ex: "Você ainda não possui reservas").

## 8. Priorização da Automação
Para otimizar o esforço e garantir a cobertura dos fluxos de maior valor e risco, a automação seguirá a seguinte prioridade:

### P1 (Alta Prioridade - Smoke Tests e Happy Paths Críticos):
* CT-AUTH-002.1 (Login com sucesso - API e UI)
* CT-AUTH-001.1 (Registro com sucesso - API e UI)
* Fluxo E2E (P1): CT-MOVIE-002.3 -> CT-RESERVE-001.1 -> CT-RESERVE-002.3 -> CT-RESERVE-003.2 (Fluxo completo de reserva e verificação no histórico).
* CT-MOVIE-001.3 (Acessar detalhes do filme)

### P2 (Média Prioridade - Sad Paths Críticos):
* CT-AUTH-001.2 (Registro com e-mail duplicado - API)
* CT-AUTH-002.3 (Login com senha incorreta - UI)
* CT-AUTH-003.2 (Acesso a rota protegida pós-logout - UI)
* CT-RESERVE-001.4 (Tentar selecionar assento ocupado - UI)
* CT-RESERVE-001.5 (Tentar prosseguir sem assentos - UI)

### P3 (Baixa Prioridade - Foco Manual):
* Testes de responsividade (CT-HOME-001.4, CT-NAV-001.4, CT-MOVIE-001.4).
* Validações visuais (cores, fontes, qualidade de pôsteres).
* Testes exploratórios gerais.

## 9. Riscos e Premissas

### Riscos:
* Ambiente de teste instável ou indisponível.
* Falta de dados de teste (massa de dados) para filmes e sessões.
* Mudanças frequentes nos Critérios de Aceitação (AC) ou na UI.

### Premissas:
* As Histórias de Usuário e ACs estão aprovadas e estáveis.
* A equipe de desenvolvimento fornecerá builds regulares para o ambiente de QA.
* A documentação da API (Swagger/OpenAPI) estará disponível e atualizada.

