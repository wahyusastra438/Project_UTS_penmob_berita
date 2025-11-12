import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Login"),
      ),
      body: const Center(
        child: Text("Fitur Google Sign-In akan diimplementasikan di sini."),
      ),
    );
  }
}