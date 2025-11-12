import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Aplikasi Berita"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Silakan login untuk melanjutkan",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            
            authProvider.status == AuthStatus.authenticating
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    icon: const Icon(Icons.login), 
                    label: const Text("Sign In with Google"),
                    onPressed: () {
                      context.read<AuthProvider>().signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}