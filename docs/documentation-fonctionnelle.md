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

### 4.2 Navigation multi-ecrans

Navigation via menu lateral:

- Accueil
- Mes taches
- Mode Focus
- Parametres

### 4.3 Mode Focus

Le Mode Focus affiche uniquement les taches jugees prioritaires:

- taches de priorite haute, ou
- taches dont la date limite est due aujourd'hui (ou depassee),

puis trie les elements par urgence (priorite puis echeance).

### 4.4 Synchronisation API

- Chargement des taches depuis une API REST.
- Synchronisation manuelle depuis l'ecran Parametres.
- Gestion des erreurs reseau avec messages utilisateur.

## 5. Regles de gestion

- Le titre d'une tache est obligatoire.
- Les champs description, photo et echeance sont optionnels.
- La suppression d'une tache est irreversible.
- Une tache peut etre classee dans une seule categorie et une seule priorite.
- Le Mode Focus applique une logique metier dediee aux urgences.
- En cas d'erreur API, un message explicite est affiche.

## 6. Exigences non fonctionnelles

- Application en francais.
- Interface fluide et lisible.
- Coherence visuelle sur tous les ecrans (charte graphique commune).
- Temps de reponse acceptable sur operations CRUD standards.
- Architecture code maintenable et extensible.

## 7. Limites actuelles

- Pas de systeme d'authentification dans la version actuelle.
- Le serveur fourni est un mock local (usage pedagogique / dev).
- Pas de fonctionnalite de partage collaboratif multi-utilisateurs.

## 8. Evolutions fonctionnelles proposees

- Authentification (email/mot de passe ou OAuth).
- Filtrage et recherche avances.
- Rappels/notifications locales.
- Statistiques personnelles (taches creees, completees, retard).
