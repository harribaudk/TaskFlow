# Documentation technique - TaskFlow

## 1. Vue d'ensemble technique

TaskFlow est une application mobile developpee avec **Flutter** (Dart) en architecture modulaire, connectee a une API REST.

Principes retenus:

- separation claire UI / logique metier / acces donnees,
- composants reutilisables pour la coherence visuelle,
- gestion centralisee de l'etat des taches via un store (`ChangeNotifier`),
- architecture evolutive pour brancher un backend reel.

## 2. Stack et dependances

Dependances principales:

- `flutter` / `material`
- `http` (consommation API REST)
- `flutter_localizations` (localisation fr-FR)
- `google_fonts` (typographie Inter)
- `image_picker` (ajout photo)
- `permission_handler` (gestion permissions camera/galerie)
- `shared_preferences` (stockage local des identifiants et de la session)

Tests:

- `flutter_test`
- `flutter_lints`

## 3. Structure du projet

- `lib/main.dart` : point d'entree, initialisation du `TaskStore` et `AuthController`.
- `lib/app.dart` : configuration globale `MaterialApp`, garde d'authentification, routes, theme, locale.
- `lib/auth/` : service d'authentification locale + controller d'etat.
- `lib/routes/` : constantes de navigation (login, register, ecrans principaux).
- `lib/screens/` : ecrans applicatifs (Login, Register, Accueil, Taches, Focus, Parametres, Formulaire).
- `lib/widgets/` : composants reutilisables (scaffold, drawer, boutons, champs, tiles, `AuthScope`...).
- `lib/models/` : entites metier (`Task`, `TaskCategory`, `TaskPriority`).
- `lib/data/` : repository + store metier.
- `lib/api/` : client HTTP, mapping JSON, exceptions.
- `lib/theme/` : tokens visuels (couleurs, styles texte, theme global).
- `tool/mock_task_api_server.dart` : serveur mock local REST.
- `test/` : tests unitaires/widget.

## 4. Architecture applicative

### 4.1 Couche presentation (UI)

- Ecrans Flutter stateless/stateful.
- Navigation nommee via routes.
- `TaskFlowScaffold` et `TaskFlowDrawer` pour un cadre commun.

### 4.2 Couche authentification

- `LocalAuthService` :
  - initialise un compte demo si aucun compte n'existe,
  - stocke email + hash mot de passe dans `SharedPreferences`,
  - gere login / register / logout,
  - restaure la session (`session_email`) au demarrage.
- `AuthController` (`ChangeNotifier`) :
  - expose `isInitializing`, `isAuthenticated`, `currentEmail`, `error`,
  - notifie l'UI lors des changements d'etat.
- `AuthScope` : injection du controller dans l'arbre de widgets.

### 4.3 Couche logique/metier

- `TaskStore` pilote:
  - chargement initial,
  - creation/mise a jour/suppression,
  - gestion `isLoading`, `isSaving`, `error`,
  - calcul des `focusTasks`.
- Le store notifie les ecrans (`ListenableBuilder`) pour rafraichir l'UI.

### 4.4 Couche donnees

- Contrat `TaskRepository`.
- Implementation `RestTaskRepository`.
- Appels HTTP realises par `TaskApiClient`.
- Conversion JSON <-> modele via `TaskJsonMapper`.

## 5. Modele de donnees

### 5.1 Entite `Task`

Attributs:

- `id: String`
- `title: String` (obligatoire)
- `description: String?`
- `category: TaskCategory`
- `priority: TaskPriority`
- `deadline: DateTime?`
- `photoPath: String?`
- `completed: bool`

### 5.2 Enumerations

- `TaskCategory`: Travail, Maison, Etudes, Personnel.
- `TaskPriority`: Basse, Moyenne, Haute.

## 6. Authentification locale (implementation)

### 6.1 Fichiers concernes

| Fichier | Role |
|---------|------|
| `lib/auth/local_auth_service.dart` | Persistance et verification des identifiants |
| `lib/auth/auth_controller.dart` | Etat auth pour l'interface |
| `lib/widgets/auth_scope.dart` | Acces au controller depuis les ecrans |
| `lib/screens/login_screen.dart` | UI de connexion |
| `lib/screens/register_screen.dart` | UI d'inscription locale |

### 6.2 Cles `SharedPreferences`

- `auth_email` : email du compte local
- `auth_password_hash` : hash du mot de passe (encodage base64 URL)
- `session_email` : session active (utilisateur connecte)

### 6.3 Garde d'acces applicative

Dans `lib/app.dart` :

- si `isInitializing` : ecran de chargement,
- si non authentifie : routes login/register uniquement,
- si authentifie : routes metier (Accueil, Taches, Focus, Parametres),
- rechargement des taches declenche apres connexion valide.

### 6.4 Routes auth

- `/login` : ecran de connexion
- `/register` : ecran d'inscription locale

## 7. API REST

Base URL:

- Android emulator: `http://10.0.2.2:8000/api`
- Desktop/Web local: `http://localhost:8000/api`
- Override possible via `--dart-define=API_BASE_URL=...`

Endpoints utilises:

- `GET /tasks` -> liste des taches
- `POST /tasks` -> creation
- `PUT /tasks/{id}` -> mise a jour
- `DELETE /tasks/{id}` -> suppression

Comportements:

- Timeout des appels: 15s.
- Headers JSON (`Content-Type`, `Accept`).
- Gestion d'erreurs via `ApiException`.

## 8. Demarrage local

1. Installer les dependances:
   - `flutter pub get`
2. Lancer le mock API:
   - `dart run tool/mock_task_api_server.dart`
3. Lancer l'application:
   - `flutter run`

## 9. Gestion des permissions mobiles

Dans le formulaire de tache:

- demande permission camera pour photo directe,
- demande permission photos pour import galerie,
- message utilisateur si permission refusee.

## 10. Tests

Tests existants lies a l'authentification :

- `test/local_auth_service_test.dart` : login, register, logout, persistance session
- `test/widget_test.dart` : acces app apres connexion + affichage login si deconnecte

Commandes :

- `flutter test`
- `flutter analyze`

## 11. Roadmap technique

- Remplacer l'auth locale par une auth distante (token JWT/OAuth).
- Introduire la completion de tache dans le flux UI.
- Ajouter stockage offline (cache local).
- Mettre en place CI (tests/analyze auto).
- Ajouter tests d'integration plus complets (CRUD bout en bout).