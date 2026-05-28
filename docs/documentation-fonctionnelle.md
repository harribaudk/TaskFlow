# Documentation fonctionnelle - TaskFlow

## 1. Presentation du projet

**TaskFlow** est une application mobile de gestion de taches qui permet a un utilisateur de:

- creer et organiser ses taches du quotidien,
- prioriser les actions importantes,
- suivre les echeances,
- se concentrer sur l'essentiel grace au Mode Focus.

L'objectif fonctionnel est de repondre a un besoin metier simple: **ameliorer l'organisation personnelle et la productivite** via une interface claire, rapide et coherente.

## 2. Public cible

- Etudiants qui souhaitent planifier devoirs/examens.
- Professionnels qui gerent une liste de taches operationnelles.
- Toute personne voulant centraliser ses actions personnelles.

## 3. Besoins metier couverts

- Centraliser les taches dans une application mobile.
- Qualifier chaque tache (categorie, priorite, echeance, details).
- Mettre a jour ou supprimer une tache facilement.
- Visualiser rapidement les taches urgentes.
- Permettre une synchronisation avec une API (architecture evolutive vers un backend partage avec un projet web).

## 4. Fonctionnalites principales

### 4.1 Gestion des taches (CRUD)

- **Creation** d'une tache avec:
  - titre (obligatoire),
  - description (optionnelle),
  - categorie,
  - priorite,
  - date limite (optionnelle, avec heure optionnelle),
  - photo (camera ou galerie, optionnelle).
- **Lecture** de la liste des taches.
- **Modification** d'une tache existante.
- **Suppression** d'une tache avec confirmation.

### 4.2 Authentification locale

L'application est protegee par un systeme d'authentification **locale** (donnees stockees sur l'appareil uniquement).

- **Connexion** : email + mot de passe.
- **Inscription locale** : creation ou remplacement du compte sur l'appareil.
- **Session persistante** : l'utilisateur reste connecte apres fermeture de l'app.
- **Deconnexion** : disponible depuis le menu lateral et l'ecran Parametres.

Compte de demonstration fourni par defaut :

| Champ | Valeur |
|-------|--------|
| Email | `demo@taskflow.fr` |
| Mot de passe | `demo123` |

Regles fonctionnelles :

- Sans connexion, l'utilisateur ne peut pas acceder aux ecrans principaux.
- L'email est obligatoire et doit contenir `@`.
- Le mot de passe doit contenir au moins 6 caracteres a l'inscription.
- L'inscription remplace le compte local existant sur le meme appareil.

### 4.3 Navigation multi-ecrans

Navigation via menu lateral (accessible apres connexion) :

- Accueil
- Mes taches
- Mode Focus
- Parametres

### 4.4 Mode Focus

Le Mode Focus affiche uniquement les taches jugees prioritaires:

- taches de priorite haute, ou
- taches dont la date limite est due aujourd'hui (ou depassee),

puis trie les elements par urgence (priorite puis echeance).

### 4.5 Synchronisation API

- Chargement des taches depuis une API REST.
- Synchronisation manuelle depuis l'ecran Parametres.
- Gestion des erreurs reseau avec messages utilisateur.

## 5. Parcours utilisateur

### Parcours A - Premiere connexion

1. L'utilisateur ouvre l'application.
2. Il arrive sur l'ecran **Connexion**.
3. Il se connecte avec le compte demo ou cree un compte local.
4. Il accede a l'ecran **Accueil** et peut utiliser l'application.

### Parcours B - Utilisation quotidienne

1. L'utilisateur ouvre l'app (session restauree si deja connecte).
2. Il consulte **Mes taches** ou **Mode Focus**.
3. Il cree/modifie/supprime des taches.
4. Il peut forcer une synchronisation API depuis **Parametres**.

### Parcours C - Deconnexion

1. L'utilisateur ouvre le menu lateral ou **Parametres**.
2. Il choisit **Deconnexion**.
3. Il revient a l'ecran de connexion.

## 6. Regles de gestion

- L'acces aux fonctionnalites metier necessite une session active.
- Le titre d'une tache est obligatoire.
- Les champs description, photo et echeance sont optionnels.
- La suppression d'une tache est irreversible.
- Une tache peut etre classee dans une seule categorie et une seule priorite.
- Le Mode Focus applique une logique metier dediee aux urgences.
- En cas d'erreur API, un message explicite est affiche.

## 7. Exigences non fonctionnelles

- Application en francais.
- Interface fluide et lisible.
- Coherence visuelle sur tous les ecrans (charte graphique commune).
- Temps de reponse acceptable sur operations CRUD standards.
- Architecture code maintenable et extensible.

## 8. Limites actuelles

- Authentification **locale uniquement** (pas de serveur d'auth distant).
- Un seul compte local par appareil (inscription = remplacement du compte existant).
- Le serveur fourni est un mock local (usage pedagogique / dev).
- Pas de fonctionnalite de partage collaboratif multi-utilisateurs.

## 9. Criteres d'acceptation (extraits)

- L'utilisateur doit se connecter avant d'acceder aux ecrans metier.
- La connexion avec le compte demo fonctionne des la premiere installation.
- L'inscription locale cree un compte utilisable immediatement.
- La deconnexion ramene a l'ecran de connexion.
- Le CRUD des taches reste operationnel apres authentification.

## 10. Evolutions fonctionnelles proposees

- Authentification distante (API + token JWT/OAuth).
- Filtrage et recherche avances.
- Rappels/notifications locales.
- Statistiques personnelles (taches creees, completees, retard).
