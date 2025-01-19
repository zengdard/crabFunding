time2skip
time2skip
En ligne

Luca — 13/11/2024 16:59
et dans le back
on utilise black schol
et ça renvoie
si c'ests sur ou sous evalué
time2skip — 13/11/2024 17:00
Azy
Tfacon jai déjà des backs prêts
Faudra juste l upload sur un vps ap
Luca — 13/11/2024 17:04
ouais par contre je sais pas trop comment ça marche dcp
faut que tu leades le projet et que tu me dises quoi faire
fin avant jte montre black school
Luca — 13/11/2024 17:19
Projet flutter :
-Trouver une API qui nous renvoie des options
-Faire un jolie front
-déterminer nos paramètres black schol
Luca — 13/11/2024 17:31
Faire un trello et un jira
fin faire une belle déco de gestion de projet comme d'hab
faut faire une athentification
faut un json web token
Luca — 13/11/2024 17:40
faire en sorte qu'on puisse selectionner les actions favorites etc ...
faire un système de favori quoi
Image
Luca a épinglé un message dans ce salon. Voir tous les messages épinglés. — 13/11/2024 17:42
Luca — 13/11/2024 17:43
Image
Luca a épinglé un message dans ce salon. Voir tous les messages épinglés. — 13/11/2024 17:43
Luca — 13/11/2024 17:56
Image
Image
time2skip — 18/12/2024 08:43
Je vais t'expliquer la structure de ce projet de manière simple en français.

Ce projet est divisé en deux grandes parties :

Backend (La partie serveur)
/backend/

C'est la partie qui gère toute la logique côté serveur :
La connexion des utilisateurs (auth.controller.ts)
Le calcul des options financières (blackscholes.service.ts)
La gestion de la base de données
Les différentes routes de l'API

Mobile (L'application)
/mobile/

C'est l'application que les utilisateurs vont utiliser :
Les écrans de l'application (dossier /screens)
L'écran de connexion (login_screen.dart)
L'écran d'accueil (home_screen.dart)
L'analyse des options (option_analysis_screen.dart)
Les images et icônes (dossier /assets)
Les traductions (dossier /translations)

Les fichiers importants à connaître :
docker-compose.yml : Pour lancer tout le projet
main.dart : Le point de départ de l'application mobile
main.ts : Le point de départ du serveur

C'est une application qui semble être orientée finance, avec des calculs d'options financières. Elle est construite avec :
Flutter pour l'application (qui permet de créer des apps mobiles et web)
Node.js pour le serveur
Une base de données (probablement PostgreSQL)

Est-ce qu'il y a une partie en particulier que tu voudrais que j'explique plus en détail ?
Je vais détailler chaque partie importante du projet une par une.

Configuration Racine

/.vscode/ - Configuration pour Visual Studio Code
.dockerignore - Fichiers à ignorer par Docker
.env - Variables d'environnement
.gitignore - Fichiers à ignorer par Git
docker-compose.yml - Configuration pour lancer tous les services


Backend (/backend/)

/src/ - Le code source principal
  /config/ - Configuration du serveur et de la base de données
  /controllers/ - Gestion des requêtes :
    - auth.controller.ts : Gestion authentification
    - option.controller.ts : Gestion des options financières

  /middleware/ - Fonctions intermédiaires :
    - auth.middleware.ts : Vérification connexion
    - error.middleware.ts : Gestion des erreurs
    - validation.middleware.ts : Validation des données

  /models/ - Structure des données :
    - user.model.ts : Structure utilisateur
    - search-history.model.ts : Historique recherches

  /services/ - Logique métier :
    - blackscholes.service.ts : Calculs financiers
    - yahoo.service.ts : Données de Yahoo Finance


Mobile (/mobile/)

/lib/ - Code source Flutter
  /screens/ - Les différents écrans :
    /auth/ - Écrans de connexion
    /home/ - Écran principal
    /options/ - Analyse des options

/assets/ - Ressources :
  /fonts/ - Polices de caractères
  /images/ - Images
  /translations/ - Fichiers de traduction


Database (/database/)

init.sql - Script d'initialisation de la base de données


Tests

/backend/src/tests/ - Tests du backend
/mobile/test/ - Tests de l'application mobile


Est-ce que tu voudrais des détails sur une partie spécifique ? Par exemple :
Comment fonctionne l'authentification ?
Comment sont gérés les calculs financiers ?
Comment est structurée l'interface utilisateur ?
:.
│   .dockerignore
│   .env
│   .gitattributes
│   .gitignore
│   docker-compose.yml
Afficher plus
message.txt
5 Ko
Luca — 18/12/2024 08:43
merci messir
time2skip — 18/12/2024 09:30
assets:
    
assets/images/splash.png
assets/images/splash_android12.png
assets/icons/app_icon.png
assets/icons/app_icon_foreground.png
assets/translations/fr.json
Luca — 19/12/2024 09:05
Type de fichier joint : spreadsheet
Exercice plage landaise.xlsx
412.81 KB
Type de fichier joint : spreadsheet
Exercice plage bretonne.xlsx
352.85 KB
Luca — 19/12/2024 11:39
Image
Image
Image
Image
Image
time2skip — Hier à 11:19
Image
Image
Image
Luca — Hier à 11:24
Image
Image
time2skip — Aujourd’hui à 13:17
Structure du dossier pour le volume Windows-SSD
Le numéro de série du volume est CC38-5817
C:.
│   .dockerignore
│   .env
│   .gitattributes
Afficher plus
message.txt
30 Ko
Présentation de l'API Yahoo Finance
L'API Yahoo Finance permet aux développeurs d'accéder à des données financières en temps réel, notamment les prix des actions, les informations sur les entreprises, les devises et d'autres instruments financiers.

Description de l'API
L'API Yahoo Finance offre des données financières complètes qui incluent des informations sur les actions, les indices boursiers, les devises, les matières premières et les fonds communs de placement. Elle fournit des données historiques et en temps réel, ainsi que des analyses et des prévisions financières.
Afficher plus
message.txt
3 Ko
time2skip — Aujourd’hui à 14:43
Image
Image
Image
Image
time2skip — Aujourd’hui à 15:29
jgoffin.bach2025@esaip.org
Luca — Aujourd’hui à 15:45
https://www.notion.so/Projet-crowd-17568112bd8c803083cfeafdcb508469?pvs=4
.






pour le git 
Projet Flutter - Analyse d'Actions avec Modèle Black-Scholes

Ce projet est une application Flutter qui combine une interface utilisateur (frontend) et un modèle mathématique en backend pour évaluer les actions en bourse. En utilisant le modèle de Black-Scholes, l'application détermine si une action est surévaluée ou sous-évaluée.

Fonctionnalités
Afficher plus
Read me.txt
4 Ko
.







rajouter des screens code + app 
Luca — Aujourd’hui à 17:10
v2 avec screen 
Type de fichier joint : document
Rapport flutter.docx
252.72 KB
﻿
Projet Flutter - Analyse d'Actions avec Modèle Black-Scholes

Ce projet est une application Flutter qui combine une interface utilisateur (frontend) et un modèle mathématique en backend pour évaluer les actions en bourse. En utilisant le modèle de Black-Scholes, l'application détermine si une action est surévaluée ou sous-évaluée.

Fonctionnalités

Frontend Mobile App :

Affiche des écrans clés :

ProfileScreen : Gérer votre profil utilisateur.

LoginScreen : Accédez à votre compte utilisateur.

OptionAnalysisScreen : Analyse des options d'actions.

HomeScreen : Tableau de bord principal.

Gère l'authentification et les options via les Providers :

AuthProvider : Gère l'authentification utilisateur.

OptionProvider : Gère l'analyse des options.

Backend :

Basé sur Node.js avec TypeScript.

Implémentation des API principales dans les contrôleurs :

AuthController : Gère l'inscription, la connexion, et l'authentification.

OptionController : Fournit des données pour l'analyse des options.

Utilise PostgreSQL pour stocker les données utilisateurs et historiques de recherche :

Modèles :

User : Stocke les informations des utilisateurs.

SearchHistory : Enregistre l'historique des recherches.

Services backend clés :

BlackScholesService : Effectue les calculs du modèle Black-Scholes.

YahooService : Récupère les données de marché en direct.

Services communs :

ApiService : Fournit des méthodes pour effectuer des appels HTTP entre le frontend et le backend.

ApiInterceptor : Gère les erreurs et la récupération de jetons d'authentification.

Structure du Projet

Frontend

lib/screens : Contient les interfaces utilisateur (écrans).

lib/providers : Gère la logique d'état et les appels au backend.

lib/services : Fournit des services pour les appels API.

lib/widgets : Composants UI réutilisables (par exemple, OptionResultCard, CustomTextField).

Backend

src/controllers :

auth.controller.ts : Contrôleur d'authentification.

option.controller.ts : Contrôleur pour l'analyse des options.

src/services :

blackscholes.service.ts : Implémentation du modèle Black-Scholes.

yahoo.service.ts : Service pour récupérer les données de marché.

src/models :

user.model.ts : Modèle utilisateur pour PostgreSQL.

search-history.model.ts : Modèle d'historique des recherches.

Installation

Prérequis

Flutter SDK (version recommandée : 3.x ou supérieure)

Node.js avec TypeScript

PostgreSQL (pour la base de données)

Instructions

Clonez le dépôt :

git clone https://github.com/votre-utilisateur/nom-du-projet.git
cd nom-du-projet

Configurez le backend :

Naviguez vers le dossier backend et installez les dépendances :

cd backend
npm install

Configurez les variables d'environnement (échantillon : .env.debug).

Lancez le serveur backend :

npm run dev

Configurez le frontend :

Naviguez vers le dossier mobile et installez les dépendances Flutter :

cd mobile
flutter pub get

Lancez l'application Flutter sur un simulateur ou appareil physique :

flutter run

Modèle de Black-Scholes

Le modèle est implémenté dans le backend dans BlackScholesService. La formule est utilisée pour évaluer les options en fonction des paramètres fournis (prix actuel, prix d'exercice, volatilité, etc.).


Auteur 

Développé par Jérémy Goffin et Luca Giordano.
Read me.txt
4 Ko