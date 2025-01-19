CroW Mobile - Application Flutter pour l'analyse d'options

INSTALLATION ET CONFIGURATION
---------------------------

1. Prérequis :
   - Docker et Docker Compose installés
   - Git installé

2. Premier lancement :
   a. Ouvrir un terminal dans le dossier racine du projet
   b. Exécuter les commandes suivantes :
      cd mobile
      chmod +x init.sh dev.sh build.sh
      ./init.sh

3. Structure des dossiers requise :
   mobile/
   ├── assets/
   │   ├── images/
   │   │   ├── splash.png
   │   │   └── splash_android12.png
   │   ├── icons/
   │   │   ├── app_icon.png
   │   │   └── app_icon_foreground.png
   │   ├── translations/
   │   │   └── fr.json
   │   └── fonts/
   │       ├── Poppins-Regular.ttf
   │       ├── Poppins-Medium.ttf
   │       └── Poppins-Bold.ttf

4. Commandes importantes :
   - Lancer l'application complète :
     docker-compose up --build

   - Lancer uniquement le développement Flutter :
     docker-compose run -p 8080:8080 -p 42000:42000 mobile ./dev.sh

   - Construire l'APK :
     docker-compose run mobile ./build.sh

DÉVELOPPEMENT
------------

1. Points d'accès :
   - Application Web : http://localhost:8080
   - API Backend : http://localhost:3000
   - Base de données : localhost:3306
   - Redis : localhost:6379

2. Fichiers importants :
   - Configuration API : lib/config/api_config.dart
   - Routes principales : lib/main.dart
   - Écrans : lib/screens/
   - Services : lib/services/
   - Modèles : lib/models/

3. En cas de problème :
   - Nettoyer les conteneurs :
     docker-compose down -v
     docker system prune -f

   - Réinitialiser Flutter :
     cd mobile
     flutter clean
     ./init.sh

   - Vérifier les logs :
     docker-compose logs -f mobile

DÉPLOIEMENT
-----------

1. Version Web :
   - La version web est construite automatiquement
   - Accessible via http://localhost:8080

2. Version Android :
   - L'APK est généré dans : mobile/build/app/outputs/flutter-apk/app-release.apk
   - Pour construire : docker-compose run mobile ./build.sh

3. Production :
   - Modifier l'URL de l'API dans lib/config/api_config.dart
   - Mettre à jour les variables d'environnement dans docker-compose.yml

MAINTENANCE
----------

1. Mise à jour des dépendances :
   cd mobile
   flutter pub upgrade

2. Nettoyage :
   cd mobile
   flutter clean
   rm -rf build/
   rm -rf .dart_tool/
   ./init.sh

3. Régénération des assets :
   cd mobile/assets/fonts
   ./download_fonts.sh

NOTES IMPORTANTES
----------------

- Toujours exécuter init.sh après un clone frais du projet
- Vérifier que tous les ports requis sont disponibles
- En cas d'erreur de build, vérifier les permissions des scripts
- Les fichiers de configuration sont dans .env et docker-compose.yml
- Le backend doit être démarré avant l'application mobile

CONTACT ET SUPPORT
-----------------

Pour toute question ou problème :
- Créer une issue sur le dépôt Git
- Consulter la documentation Flutter : https://flutter.dev/docs
- Vérifier les logs Docker pour le débogage
