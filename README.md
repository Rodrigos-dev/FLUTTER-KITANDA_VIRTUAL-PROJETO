# 🍓 Kitanda App - Loja Virtual de Frutas

Aplicativo desenvolvido com **Flutter** simulando uma loja virtual para uma kitanda, permitindo:

- Visualização de produtos.
- Carrinho de compras.
- Login, cadastro e splash screen.
- Integração com APIs e animações.
- Criação de APK para Android e iOS.

---

## 📸 Screenshot da Estrutura do Projeto

<h3 align="center">📸 Screenshots</h3>

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/dfa74217-f0a0-45b9-9b3f-1ea21ba3887a" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/388a6894-7444-45a2-9d41-07147db94d5f" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/cde52359-e74a-4d9d-a8cb-d1fa4b418632" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/ceac486c-79b8-46fd-8ddc-b7b033f2fa1c" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/bb0300aa-3feb-4541-8a2d-17b02ddddbe7" width="80"/></td> 
  </tr>
  <tr>    
    <td><img src="https://github.com/user-attachments/assets/3cad653c-6692-4b59-8bf8-03b255653456" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/a9cf3021-83e5-4d86-99a7-33a4ffe3317d" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/1d57b73d-0bee-4668-b9eb-59e648e73755" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/2138ec56-6252-4ebd-80d6-7734e6fca689" width="80"/></td>
    <td><img src="https://github.com/user-attachments/assets/1721a69c-4b53-4403-a2f4-b93b9334175f" width="80"/></td>
  </tr>  
</table>

---

## 🗂 Estrutura de Pastas

| Pasta | Descrição |
|-------|-----------|
| `1 - criar projeto e config inicial` | Setup inicial do Flutter e configurações básicas. |
| `2 - LOGIN` | Formulário e layout da tela de login. |
| `3 - PAGINA DE CADASTRO` | Tela para novo usuário se cadastrar. |
| `4 - COMPONENTE DE INPUTFIELD` | Campo de entrada reutilizável (input). |
| `5 - TABMENU` | Exibição de abas com navegação por tabs. |
| `6 - LIST ALL` | Tela com a listagem completa dos produtos. |
| `7 - LIST BY ID` | Tela de detalhes de um produto selecionado. |
| `8 - CARRINHO` | Tela com o carrinho de compras. |
| `9 - Pqna refatorada no código` | Otimização e ajustes no código. |
| `10 - UPDATE PERFIL` | Página para editar os dados do usuário. |
| `11 - TELA PEDIDOS` | Rastreamento dos pedidos via QR Code. |
| `12 - BACKUP` | Versão do projeto sem animações. |
| `13 - ANIMACOES` | Animações para interações do app. |
| `14 - TOAST` | Exibição de mensagens de toast. |
| `15 - GESTUREDETECTOR` | Ações ao clicar nos botões com efeito. |
| `16 - AULA 52` | Aula com ícone da loja sendo trocado. |
| `17 - NOME DO APP` | Nome e ícone para Android/iOS. |
| `17.1 - REATORANDO` | Ajuste nos títulos das telas. |
| `18 - ICONE DO APK` | Ícone final do APK para mobile. |
| `19 - SPLASH SCREEN` | Tela de carregamento inicial. |
| `19.1 - MODAL` | Tela modal para recuperação de senha. |
| `20 - GET-X, DIO` | Integração com API usando GetX e Dio. |
| `99 - HTTP E DIO` | Requisições HTTP com Dio. |
| `100 - COISAS` | Anotações e dicas para o projeto. |
| `101 - IMAGENS` | Imagens usadas nas telas. |
| `102 - CRUD MOCKADO` | CRUD com dados simulados (mock). |
| `103 - ROW` | Componente row com crescimento dinâmico. |
| `104 - CARD` | ListTile com visual de card. |
| `105 - INITSTATE` | Diferença entre initState e ngOnInit. |
| `CONTAINER - GRADIENT` | Teste de background com gradiente. |
| `LOADING` | Aplicando animação de loading básico. |

---

## 📱 Funcionalidades do App

- Listagem de produtos com imagem e preço.
- Adição ao carrinho e exclusão.
- Login e cadastro de usuários.
- Splash Screen e animações responsivas.
- Requisições HTTP simuladas e reais.
- Ícones personalizados para Android/iOS.
- Toasts, modais, gradientes e loading.

---

## 📦 Pacotes Utilizados

- `GetX`
- `Dio`
- `Fluttertoast`
- `http`
- `flutter_svg`
- `provider` (opcional)

---

## 🚀 Como rodar o projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/kitanda-app.git
   cd kitanda-app

2. Instale as dependências:

flutter pub get

3. Execute no emulador ou dispositivo:

flutter run
