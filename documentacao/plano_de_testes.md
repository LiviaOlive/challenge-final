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
* **Automação de API:** Postman (para testes manuais) e RobotFramework (para automação).
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
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-AUTH-002.1 | Realizar login com credenciais válidas | Existe um usuário cadastrado com as credenciais de teste. | 1. Navegar para a página de Login.<br>2. Preencher o campo "email" com "usuario@teste.com".<br>3. Preencher o campo "senha" com "Senha@123".<br>4. Clicar no botão "Entrar". | O usuário é autenticado, redirecionado para a Home e um token JWT é armazenado no localStorage/sessionStorage. | email: "usuario@teste.com"<br>senha: "Senha@123" |
| CT-AUTH-002.2 | Tentar login com e-mail não cadastrado | O e-mail "naoexiste@teste.com" não está no banco. | 1. Preencher "email" com "naoexiste@teste.com".<br>2. Preencher "senha" com qualquer valor.<br>3. Clicar no botão "Entrar". | Mensagem de erro "Usuário ou senha inválidos" é exibida. | email: "naoexiste@teste.com" |
| CT-AUTH-002.3 | Tentar login com senha incorreta | Usuário "usuario@teste.com" existe, mas a senha não é "senha_errada". | 1. Preencher "email" com "usuario@teste.com".<br>2. Preencher "senha" com "senha_errada".<br>3. Clicar no botão "Entrar". | Mensagem de erro "Usuário ou senha inválidos" é exibida. | email: "usuario@teste.com"<br>senha: "senha_errada" |
| CT-AUTH-002.4 | Tentar login com campos em branco | O usuário está na página de Login. | 1. Deixar o campo "email" e/ou "senha" em branco.<br>2. Clicar no botão "Entrar". | Mensagens de validação "Campo obrigatório" são exibidas. | (Nenhum dado específico, apenas campos vazios) |

#### US-AUTH-003: Logout de Usuário
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-AUTH-003.1 | Realizar logout com sucesso | Um usuário está logado na aplicação. | 1. Clicar no menu de usuário (ex: no nome ou ícone de perfil).<br>2. Clicar no botão/link "Logout" (ou "Sair"). | O token JWT é removido do localStorage/sessionStorage. O usuário é redirecionado para a página de Login ou Home (como visitante). | N/A (Usuário logado) |
| CT-AUTH-003.2 | Tentar acessar rota protegida após logout | Um usuário acabou de fazer logout. | 1. Tentar acessar diretamente uma URL protegida (ex: /perfil ou /minhas-reservas). | O usuário é redirecionado para a página de Login. O acesso à página protegida é bloqueado. | URL: /perfil |

#### US-AUTH-004: Visualizar e Gerenciar Perfil do Usuário
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-AUTH-004.1 | Validar dados do perfil | Usuário logado com nome: "Usuário Teste", email: "usuario@teste.com", função: "cliente". | 1. Acessar a página "Perfil" (ou "Minha Conta"). | Os campos "nome", "email" e "função" são exibidos corretamente com os dados do usuário. | N/A (Usuário logado) |
| CT-AUTH-004.2 | Editar e salvar o nome | Usuário logado está na página de Perfil. | 1. Clicar em "Editar" (se houver).<br>2. Alterar o campo "nome" para "Usuário Teste Editado".<br>3. Clicar em "Salvar".<br>4. Recarregar a página (F5). | Mensagem "Perfil atualizado com sucesso" é exibida. Após recarregar, o novo nome ("Usuário Teste Editado") permanece. | nome: "Usuário Teste Editado" |
| CT-AUTH-004.3 | Validar separação das páginas de perfil e reservas | Usuário logado. | 1. Acessar a página de Perfil.<br>2. Acessar a página "Minhas Reservas". | As páginas são distintas e mostram informações diferentes (Perfil = dados do usuário; Reservas = lista de reservas). | N/A |
| CT-AUTH-004.4 | Tentar salvar perfil com nome em branco | Usuário logado está na página de Perfil. | 1. Editar o perfil.<br>2. Apagar todo o conteúdo do campo "nome".<br>3. Clicar em "Salvar". | Mensagem de erro "Nome não pode ficar em branco" é exibida. A alteração não é salva. | nome: "" (vazio) |

### Módulo: Navegação e Home
#### US-HOME-001: Página Inicial Atrativa
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-HOME-001.1 | Validar banner principal | N/A | 1. Acessar a página Home (/). | O banner principal (herói) é exibido e ocupa o espaço designado. | N/A (Teste Visual) |
| CT-HOME-001.2 | Validar seção "Filmes em Cartaz" | Existem filmes cadastrados no banco de dados. | 1. Acessar a página Home (/).<br>2. Rolar a página até a seção "Filmes em Cartaz". | A seção exibe uma lista (ou carrossel) de pôsteres dos filmes. | N/A (Teste Funcional/Visual) |
| CT-HOME-001.3 | Validar links rápidos e menu | N/A | 1. Acessar a página Home (/).<br>2. Clicar nos itens do menu principal (ex: "Filmes", "Login"). | O usuário é redirecionado corretamente para as páginas correspondentes. | N/A |
| CT-HOME-001.4 | Validar responsividade da Home | N/A | 1. Acessar a página Home.<br>2. Redimensionar o navegador para viewports de Mobile e Tablet. | O layout se adapta corretamente: o banner é redimensionado, o grid de filmes se ajusta (ex: 1 coluna no mobile), o menu vira "hambúrguer". | Viewports: 390px, 768px |

#### US-NAV-001: Navegação Intuitiva
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-NAV-001.1 | Validar persistência do cabeçalho | N/A | 1. Acessar a Home.<br>2. Navegar para a página de Detalhes de um filme.<br>3. Navegar para a página de Login. | O cabeçalho (com o logo e o menu de navegação) está presente e consistente em todas as páginas. | N/A |
| CT-NAV-001.2 | Validar menu (usuário logado) | Um usuário está logado. | 1. Acessar qualquer página. | O menu de navegação exibe os links "Minhas Reservas", "Perfil" e "Logout" (ou equivalentes). | N/A (Usuário logado) |
| CT-NAV-001.3 | Validar menu (visitante) | O usuário não está logado (visitante). | 1. Acessar qualquer página. | O menu de navegação exibe os links "Login" e "Registro". | N/A (Visitante) |
| CT-NAV-001.4 | Validar menu "hambúrguer" (responsivo) | N/A | 1. Acessar o site em um viewport móvel.<br>2. Clicar no ícone de menu "hambúrguer". | O menu completo é exibido (ex: como um drawer lateral) e seus links são funcionais. | Viewport: 390px |
| CT-NAV-001.5 | Validar feedback visual da página ativa | N/A | 1. Acessar a página "Filmes". | O link "Filmes" no menu principal deve ter um destaque visual (ex: sublinhado, cor diferente) indicando que é a página ativa. | N/A (Teste Visual) |

### Módulo: Filmes e Sessões
#### US-MOVIE-001: Navegar na Lista de Filmes
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-MOVIE-001.1 | Validar exibição do grid de filmes | Filmes cadastrados no banco. | 1. Acessar a página de listagem de filmes. | Os filmes são exibidos em formato de grid. Pôsteres têm boa qualidade. | N/A (Teste Visual) |
| CT-MOVIE-001.2 | Validar informações do card do filme | Filmes cadastrados com metadados completos. | 1. Acessar a página de listagem de filmes.<br>2. Inspecionar um card de filme. | O card exibe: Título, Classificação (ex: 14), Gêneros, Duração e Data de Lançamento. | N/A (Teste Visual) |
| CT-MOVIE-001.3 | Clicar em um card de filme | Um filme com ID "123" existe. | 1. Acessar a página de listagem de filmes.<br>2. Clicar no pôster/título do filme (ID "123"). | O usuário é redirecionado para a página de detalhes desse filme (ex: /filme/123). | ID do Filme: 123 |
| CT-MOVIE-001.4 | Validar responsividade do grid | Filmes cadastrados. | 1. Acessar a página de listagem.<br>2. Redimensionar o navegador para viewports de Mobile e Tablet. | O grid se ajusta (ex: 4 colunas no Desktop, 2 no Tablet, 1 ou 2 no Mobile) sem quebrar o layout. | Viewports: 390px, 768px |

#### US-MOVIE-002: Visualizar Detalhes do Filme
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-MOVIE-002.1 | Validar informações da página de detalhes | Um filme (ID "123") existe com dados completos. | 1. Acessar a página de detalhes do filme (ex: /filme/123). | Todas as informações são exibidas: Sinopse, Elenco, Diretor, Pôster, Gênero, Duração, etc. | ID do Filme: 123 |
| CT-MOVIE-002.2 | Validar exibição da seção de horários | O filme (ID "123") possui sessões cadastradas. | 1. Acessar a página de detalhes do filme (ex: /filme/123).<br>2. Rolar a página até a seção de horários/sessões. | A seção de horários é exibida, mostrando as sessões disponíveis. | ID do Filme: 123 |
| CT-MOVIE-002.3 | Clicar em um horário disponível (E2E) | Usuário está logado. Filme (ID "123") tem sessão (ID "abc"). | 1. Acessar a página de detalhes do filme (ID "123").<br>2. Clicar em um horário/sessão disponível (ID "abc"). | O usuário é redirecionado para a página de Seleção de Assentos para aquela sessão. | ID da Sessão: "abc" |
| CT-MOVIE-002.4 | Tentar acessar detalhes de filme inexistente | O filme com ID "9999" não existe no banco. | 1. Acessar a URL /filme/9999 diretamente. | O usuário vê uma página "Filme não encontrado" (404) ou é redirecionado para a Home / Lista de Filmes. | ID do Filme: 9999 |

#### US-SESSION-001: Visualizar Horários de Sessões
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-SESSION-001.1 | Validar informações do card de sessão | Filme com sessões cadastradas. | 1. Acessar a página de detalhes de um filme.<br>2. Inspecionar um card de sessão. | O card exibe: Data, Hora, Teatro (Sala, ex: "Sala 3D") e tipo de áudio/legenda (ex: "Dublado"). | N/A (Teste Visual) |
| CT-SESSION-001.2 | Clicar em um horário (usuário logado) | Um usuário está logado. | 1. Acessar a página de detalhes de um filme.<br>2. Clicar em um horário de sessão disponível. | O usuário é levado para a página de Seleção de Assentos. | N/A (Usuário logado) |
| CT-SESSION-001.3 | Clicar em um horário (visitante) | O usuário não está logado (visitante). | 1. Acessar a página de detalhes de um filme.<br>2. Clicar em um horário de sessão disponível. | O sistema solicita o Login (seja por um modal ou redirecionando para /login). O acesso à seleção de assentos é bloqueado. | N/A (Visitante) |

### Módulo: Reservas (Fluxo E2E)
#### US-RESERVE-001: Selecionar Assentos para Reserva
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-RESERVE-001.1 | Selecionar um assento disponível | Usuário logado na página de seleção de assentos. Assento "A1" está disponível. | 1. Clicar no assento "A1". | O assento "A1" muda de cor (para "selecionado"). O subtotal é atualizado para o valor de 1 ingresso. | Assento: "A1" |
| CT-RESERVE-001.2 | Selecionar múltiplos assentos | Assentos "A1" e "A2" estão disponíveis. | 1. Clicar no assento "A1".<br>2. Clicar no assento "A2". | Os assentos "A1" e "A2" mudam de cor. O subtotal é atualizado para o valor de 2 ingressos. | Assentos: "A1", "A2" |
| CT-RESERVE-001.3 | Desmarcar um assento selecionado | Assento "A1" foi selecionado pelo usuário. | 1. Clicar novamente no assento "A1" (que está "selecionado"). | O assento "A1" volta à cor de "disponível". O subtotal é atualizado (diminuído). | Assento: "A1" |
| CT-RESERVE-001.4 | Tentar selecionar assento ocupado | Assento "B5" está ocupado (já reservado por outro usuário). | 1. Clicar no assento "B5" (que está na cor "ocupado"). | O assento não é selecionado. Nenhuma mudança ocorre no subtotal. (Opcional: um aviso "Assento ocupado" é exibido). | Assento: "B5" (Ocupado) |
| CT-RESERVE-001.5 | Tentar prosseguir sem selecionar assentos | Usuário está na página de seleção de assentos. | 1. Clicar no botão "Continuar" (ou "Checkout") sem ter selecionado nenhum assento. | O botão está desabilitado OU uma mensagem de erro "Selecione ao menos um assento" é exibida. A navegação é bloqueada. | N/A |
| CT-RESERVE-001.6 | Validar legenda de assentos | Usuário está na página de seleção de assentos. | 1. Inspecionar a legenda de cores. | A legenda exibe claramente o significado de cada cor (ex: Azul=Disponível, Cinza=Ocupado, Verde=Selecionado). | N/A (Teste Visual) |

#### US-RESERVE-002: Processo de Checkout
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-RESERVE-002.1 | Validar resumo do pedido no checkout | Usuário selecionou o assento "A1" para o filme "Filme Teste" e prosseguiu para o checkout. | 1. Acessar a página de Checkout. | O resumo do pedido exibe corretamente: "Filme Teste", Assento "A1", e o valor total correto. | N/A |
| CT-RESERVE-002.2 | Selecionar método de pagamento | Usuário está na página de Checkout. | 1. Clicar na opção de pagamento "PIX". | A opção "PIX" é selecionada e (se aplicável) as instruções de PIX (QR Code) são exibidas. | Método: PIX |
| CT-RESERVE-002.3 | Finalizar pagamento (simulado) | Usuário está no checkout com assentos e método de pagamento selecionados. | 1. Clicar no botão "Finalizar Pagamento" (ou "Confirmar Reserva"). | O pagamento é processado (simulado). O usuário vê uma mensagem de "Reserva confirmada com sucesso" e é redirecionado para "Minhas Reservas" ou uma página de sucesso. | N/A |
| CT-RESERVE-002.4 | Verificar assento ocupado pós-reserva | Usuário acabou de reservar o assento "A1" para a sessão "abc". | 1. Voltar para a página de detalhes do filme.<br>2. Selecionar a mesma sessão "abc". | Na tela de seleção de assentos, o assento "A1" agora aparece com a cor "Ocupado". | Assento: "A1" |
| CT-RESERVE-002.5 | Tentar acessar checkout diretamente (URL) | Usuário logado, mas não iniciou um fluxo de reserva. | 1. Digitar a URL /checkout diretamente no navegador. | O usuário é redirecionado para a Home (ou para o início do fluxo de reserva) ou vê uma mensagem "Seu carrinho está vazio". | URL: /checkout |

#### US-RESERVE-003: Visualizar Minhas Reservas
| ID | Descrição do Cenário | Pré-condições | Passos | Resultado Esperado | Dados de Teste |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CT-RESERVE-003.1 | Acessar "Minhas Reservas" após compra | Usuário logado que acabou de fazer uma reserva. | 1. Navegar para a página "Minhas Reservas" (pelo menu de usuário). | A nova reserva é listada na página. | N/A (Usuário logado) |
| CT-RESERVE-003.2 | Validar informações do card de reserva | Usuário possui uma reserva confirmada para "Filme Teste", assento "A1", às 18:00, via PIX. | 1. Acessar "Minhas Reservas".<br>2. Inspecionar o card da reserva. | O card exibe: Pôster, "Filme Teste", Data, Horário (18:00), Assentos ("A1"), Status ("Confirmada"), Método de Pagamento ("PIX"). | N/A (Teste Visual) |
| CT-RESERVE-003.3 | Validar página de reservas vazia | Um usuário novo (sem reservas) está logado. | 1. Acessar a página "Minhas Reservas". | Uma mensagem amigável é exibida (ex: "Você ainda não possui reservas"). A página não está quebrada. | N/A (Usuário novo) |

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

