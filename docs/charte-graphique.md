# Charte graphique - TaskFlow

## 1. Identite visuelle

TaskFlow adopte une interface moderne, claire et rassurante, orientee productivite.

Objectifs visuels:

- clarte de lecture,
- hierarchisation des informations,
- reduction de la charge cognitive,
- coherence sur tous les ecrans.

## 2. Palette de couleurs

### 2.1 Couleurs principales

- `Primary` : `#2563EB` (bleu principal de l'application)
- `Primary Dark` : `#1D4ED8` (variation pour contraste et etats)
- `Secondary` : `#10B981` (accent positif / categorie)
- `Focus Accent` : `#0D9488` (mode Focus)

### 2.2 Couleurs de surface et texte

- `Background` : `#F8FAFC`
- `Surface` : `#FFFFFF`
- `Text Primary` : `#0F172A`
- `Text Secondary` : `#64748B`
- `Border` : `#E2E8F0`
- `Error` : `#EF4444`

### 2.3 Couleurs metier (priorites)

- Priorite haute : `#EF4444`
- Priorite moyenne : `#F59E0B`
- Priorite basse : `#6366F1`

## 3. Typographie

Police de reference:

- **Inter** (Google Fonts), appliquee globalement.

## 4. Iconographie

- Utilisation des icones Material Design.
- Regles:
  - icone + texte sur actions importantes,
  - taille standard 18 a 28 px selon contexte,
  - couleur derivee de la semantique (primaire, secondaire, erreur, focus).

## 5. Composants UI

### 5.1 Boutons

- Bouton principal:
  - fond bleu primaire,
  - texte blanc,
  - hauteur minimale 48 px,
  - rayon 12 px.
- Bouton secondaire:
  - contour bleu primaire,
  - fond transparent,
  - meme hauteur/rayon pour coherence.

### 5.2 Champs de formulaire

- Fond blanc (`Surface`), contour `Border`.
- Rayon 12 px.
- Focus avec contour primaire epaisseur 2.
- Padding horizontal 16, vertical 14.

### 5.3 Cartes et listes

- Cartes sans elevation aggressive.
- Bordure douce `Border`.
- Espacement interne regulier (12-16 px).
- Separation lisible entre elements de liste.

## 6. Espacements et grille

- Espacement base: 8 px.
- Multiples usuels: 8, 12, 16, 24, 32.
- Marges ecran majoritairement 16 ou 24 px.
- Objectif: rythme visuel stable et predictible.

## 7. Navigation visuelle

- Drawer lateral comme navigation principale.
- Ecran courant visuellement souligne:
  - icone active,
  - texte primaire,
  - fond de selection leger.
- Header drawer avec branding TaskFlow.

## 8. Etats UI

- **Chargement**: indicateur circulaire.
- **Vide**: illustration iconique + message pedagogique + CTA.
- **Erreur**: message contextualise en couleur erreur + action de reprise.
- **Selection**: chips/categories/priorites avec couleur active.