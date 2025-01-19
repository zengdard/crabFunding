import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crow_mobile/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthProvider>().logout();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          },
          child: const Text('Déconnexion'),
        ),
      ),
    );
  }
}
