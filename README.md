# 🎬 Testes Cinema App - Desafio Final Compass

Este diretório contém os testes (UI e API) para o projeto `cinema-challenge`. 

## 📁 Estrutura de Pastas

```plaintext
testes/
├── ui/
│   ├── 01_auth.robot
│   ├── 02_home_nav.robot
│   ├── 03_fluxo_filmes.robot
│   └── 04_fluxo_reserva.robot
│
├── api/
│   ├── 01_auth_api.robot
│   ├── 02_movies_api.robot
│   └── 03_reserva_api.robot
│
├── resources/
│   ├── common_keywords.robot
│   ├── ui_keywords.robot
│   ├── api_keywords.robot
│   └── variables.robot
│
├── documentacao/
│   └── imagens/
│   └── bugs.md
│   └── historias_de_usuario.md
│   └── mapas-mentais.md
│   └── plano_de_testes.md
│   
├── .gitignore
├── README.md
└── requirements.txt
```

## ⚙️ Pré-requisitos

- Python 3.8+
- Robot Framework
- Chrome/Firefox instalado
- Cinema App rodando (frontend e backend)

## 📦 Instalação

```bash
pip install -r requirements.txt
```

## 🚀 Execução dos Testes

### Testes de UI
```bash
# Todos os testes de UI
robot -d results testes/ui/

# Teste específico
robot -d results testes/ui/01_auth.robot
```

### Testes de API
```bash
# Todos os testes de API
robot -d results testes/api/

# Teste específico
robot -d results testes/api/01_auth_api.robot
```

### Todos os Testes
```bash
robot -d results testes/
```

### Como Executar
1. Clone o repositório
2. Instale as dependências: `pip install -r requirements.txt`
3. Inicie o Cinema App (frontend na porta 3002 e backend na porta 3000)
4. Execute os testes com os comandos acima
5. Verifique os relatórios na pasta `results/`

## 🔧 Configuração

Antes de executar os testes, certifique-se de que:

1. O frontend está rodando em `http://localhost:3002`
2. O backend/API está rodando em `http://localhost:3000`
3. O banco de dados está configurado e acessível

## 📊 Relatórios

Os resultados dos testes são salvos na pasta `results/` com:
- `report.html` - Relatório detalhado
- `log.html` - Log de execução
- `output.xml` - Dados em XML

## 🧪 Cobertura de Testes

### UI Tests
- Autenticação (registro e login)
- Navegação na home
- Fluxo de filmes (listagem, detalhes, busca)
- Fluxo de reservas (criação, visualização)

### API Tests
- Autenticação via API
- Endpoints de filmes
- Endpoints de reservas

## 📚 Documentação

O projeto inclui documentação completa na pasta `documentacao/`:

- **bugs.md** - Relatório detalhado dos bugs encontrados durante os testes
- **historias_de_usuarios.md** - Documentação dos cenários e histórias de usuário testados
- **mapas-mentais.md** - Mapas mentais e diagramas do processo de testes
- **planos_de_testes.md** - Estratégia e planejamento dos testes executados
- **imagens/** - Imagens de mapas mentais para documentá-los em mapas-mentais.md

## 🐛 Bugs Identificados

Durante a execução dos testes, foram identificados diversos bugs críticos e de interface:

### Bugs Críticos
- Falha no carregamento da lista de filmes (API)
- Erro 500 na rota de registro de usuários
- Rota POST /api/v1/sessions não encontrada

### Bugs de Interface
- Sobreposição de texto em campos de input
- Imagens de pôster não carregam corretamente
- Problemas visuais nos campos de login

**Para detalhes completos dos bugs, consulte o arquivo `documentacao/bugs.md` e as Issues no GitHub do projeto.**