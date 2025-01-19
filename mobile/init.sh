#!/bin/bash

# Création des dossiers
mkdir -p assets/{images,icons,translations,fonts}

# Téléchargement des polices
cd assets/fonts
curl -O https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Regular.ttf
curl -O https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Medium.ttf
curl -O https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Bold.ttf
cd ../..

# Activation du support web et installation des dépendances
flutter create . --platforms=web
flutter pub get
flutter build web --release