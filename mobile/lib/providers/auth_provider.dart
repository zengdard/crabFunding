import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? error;
  bool isLoading = false;
  bool isAuthenticated = false;  // Ajout de la propriété

  Future<bool> login(String email, String password) async {
    if (email == 'test@gmail.com' && password == 'testtest') {
      isAuthenticated = true;  // Mise à jour du statut
      notifyListeners();
      return true;
    }
    error = 'Identifiants invalides';
    notifyListeners();
    return false;
  }

  Future<bool> register(String email, String password) async {
    if (email == 'test@gmail.com' && password == 'testtest') {
      isAuthenticated = true;  // Mise à jour du statut
      notifyListeners();
      return true;
    }
    error = 'Inscription impossible';
    notifyListeners();
    return false;
  }

  void logout() {  // Ajout de la méthode logout
    isAuthenticated = false;
    notifyListeners();
  }
}
