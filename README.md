# CRUD Flutter - Gestão de Produtos e Clientes

Este projeto é uma aplicação Flutter desenvolvida para demonstrar operações completas de CRUD (Create, Read, Update, Delete), focada em boas práticas de arquitetura, validação de formulários e integração com API REST simulada.

## 🚀 Funcionalidades

### 📦 Gestão de Produtos
- Listagem de produtos com imagem e preço.
- Cadastro e Edição de produtos.
- Validação de formulários.
- Máscara de moeda R$ (Real) automática.
- Tratamento de imagens quebradas (placeholder).

### 👥 Gestão de Clientes (Costumers)
- Cadastro completo de clientes.
- **Integração com ViaCEP**: Preenchimento automático de endereço ao digitar o CEP.
- Validação de CPF/CNPJ e Telefone usando `brasil_fields`.
- Atualização e remoção de clientes.
- Sanitização de dados antes do envio para a API (remoção de máscaras).

## 🛠️ Tecnologias e Pacotes Utilizados

- **Flutter & Dart**: SDK Base.
- **Dio**: Cliente HTTP para requisições.
- **Brasil Fields**: Formatação e máscaras para padrões brasileiros (Moeda, CEP, Telefone).
- **Fluttertoast**: Feedback visual para o usuário.
- **JSON Server**: Simulação de API Backend.

## 📂 Estrutura do Projeto

O projeto segue uma separação clara de responsabilidades:

```
lib/
├── components/     # Widgets reutilizáveis (InputForm, ButtonForm)
├── controller/     # Lógica de negócio e gerência de estado (ValueNotifier)
├── models/         # Classes de dados e serialização JSON
├── repositories/   # Comunicação direta com a API e tratamento de dados
└── views/          # Telas e interface do usuário
```

## ⚙️ Como Rodar o Projeto

Este projeto depende de um backend local rodando na porta **3001**. Siga os passos abaixo:

### 1. Configurar o Backend (Mock)

A pasta `backend` contém o servidor JSON.

1. Navegue até a pasta do backend:
   ```bash
   cd backend
   ```
2. Instale as dependências (caso não tenha feito):
   ```bash
   npm install
   ```
3. Inicie o servidor:
   ```bash
   npm start
   ```
   *O servidor rodará em `http://localhost:3001` (ou `http://10.0.2.2:3001` para emulador Android).*

### 2. Rodar o App Flutter

1. Volte para a raiz do projeto e instale as dependências do Flutter:
   ```bash
   flutter pub get
   ```
2. Execute o aplicativo:
   ```bash
   flutter run
   ```

## 📝 Detalhes da API

O arquivo `backend/db.json` serve como banco de dados.
- **Base URL (Android Emulator):** `http://10.0.2.2:3001`
- **Endpoints:**
  - `GET /products`
  - `GET /costumers`

## 📱 Telas

O aplicativo conta com navegação nomeada e transições fluidas entre a lista de registros e os formulários de criação/edição.
