# 🏢 Patrimônios SENAI

> Aplicativo móvel para gerenciamento e controle de inventário de patrimônios, desenvolvido com **Flutter** e **GetX**.

---

## 📌 Sobre o Projeto

O **Patrimônios SENAI** é uma solução mobile desenvolvida para facilitar o cadastro, monitoramento, busca e manutenção dos bens patrimoniais da instituição. A aplicação conta com interface inspirada na identidade visual do **SENAI**, integrando-se a uma API REST para operações completas de CRUD (Create, Read, Update, Delete).

---

## 🚀 Funcionalidades

- 📋 **Listagem de Patrimônios:** Visualização de todos os itens cadastrados com identificação de número de inventário, descrição, local e responsável.
- 🔍 **Busca em Tempo Real:** Filtro rápido por termo para localizar itens específicos instantaneamente.
- 📄 **Detalhes do Patrimônio:** Visualização aprofundada de todas as informações do item, incluindo data de registro.
- ➕ **Cadastro de Novos Itens:** Formulário com validação para inclusão de novos patrimônios.
- ✏️ **Edição:** Atualização de dados cadastrais (descrição, responsável, local e número de inventário).
- 🗑️ **Exclusão:** Remoção de patrimônios com diálogo de confirmação.
- 📱 **Device Preview:** Suporte integrado à pré-visualização em múltiplos tamanhos de tela e plataformas.

---

## 🛠️ Tecnologias Utilizadas

- **[Flutter](https://flutter.dev/)** (SDK ^3.12.2) - Framework multiplataforma
- **[Dart](https://dart.dev/)** - Linguagem de programação
- **[GetX](https://pub.dev/packages/get)** - Gerenciamento de estado reativo, injeção de dependências e gerenciamento de rotas
- **[HTTP](https://pub.dev/packages/http)** - Requisições assíncronas para a API REST
- **[Device Preview](https://pub.dev/packages/device_preview)** - Simulação de múltiplos dispositivos durante o desenvolvimento
- **Material Design 3** - Design de interface moderno e adaptativo

---

## 📂 Estrutura do Projeto

A arquitetura segue o padrão modular com separação de responsabilidades em camadas:

```text
lib/
├── controllers/
│   └── patrimonio_controller.dart  # Gerenciamento de estado reativo e regras de negócio com GetX
├── models/
│   └── patrimonio.dart             # Modelo de dados e serialização JSON
├── services/
│   └── patrimonio_service.dart     # Comunicação com a API REST (HTTP Client)
├── views/
│   ├── patrimonio_list_view.dart   # Tela principal com listagem e barra de pesquisa
│   ├── patrimonio_detail_view.dart # Tela de detalhes do patrimônio selecionado
│   └── patrimonio_form_view.dart   # Formulário para cadastro e edição
└── main.dart                       # Configuração de temas, rotas, bindings e inicialização
```

---

## 🌐 Integração com a API

O aplicativo se comunica com uma API REST através dos seguintes endpoints:

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/api/v1/patrimonios` | Lista todos os patrimônios |
| `GET` | `/api/v1/patrimonios?q={termo}` | Pesquisa patrimônios por termo |
| `GET` | `/api/v1/patrimonios/{id}` | Obtém detalhes de um patrimônio por ID |
| `POST` | `/api/v1/patrimonios` | Cadastra um novo patrimônio |
| `PUT` | `/api/v1/patrimonios/{id}` | Atualiza dados de um patrimônio existente |
| `DELETE` | `/api/v1/patrimonios/{id}` | Remove um patrimônio |

### ⚙️ Configuração da URL Base

O endereço da API está configurado em [`lib/services/patrimonio_service.dart`](lib/services/patrimonio_service.dart):

```dart
static const String baseUrl = 'http://localhost:8080/api/v1/patrimonios';
```

> **Dica para testes:**
> - **Emulador Android:** Utilize `http://10.0.2.2:8080/api/v1/patrimonios`
> - **Dispositivo Físico:** Utilize o IP local da sua máquina (ex: `http://192.168.x.x:8080/api/v1/patrimonios`)
> - **Web / Desktop:** Mantenha `http://localhost:8080/api/v1/patrimonios`

---

## 💻 Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado
- Editor de código (VS Code, Android Studio ou similar)
- Servidor backend/API em execução na porta configurada

### Passo a Passo

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/patrimoniosenai.git
   cd patrimoniosenai/flutter_application_1
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Inicie o aplicativo:**
   ```bash
   # Para executar em modo de depuração padrão
   flutter run

   # Ou para executar na Web:
   flutter run -d chrome

   # Ou no Windows Desktop:
   flutter run -d windows
   ```

---

## 🎨 Identidade Visual

O projeto adota a paleta de cores institucional do SENAI:
- **Cor Primária:** `#E30613` (Vermelho SENAI)
- **Tema:** Material Design 3 com suporte a modos claro e responsivo

---

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE) (ou conforme diretrizes educacionais do SENAI).
