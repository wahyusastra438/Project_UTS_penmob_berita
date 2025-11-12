import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda Berita"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selamat Datang!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            if (user != null)
              Text("Anda login sebagai: ${user.email ?? user.displayName}"),
            const SizedBox(height: 20),
            const Text("Fitur API Berita akan diimplementasikan di sini."),
          ],
        ),
      ),
    );
  }
}