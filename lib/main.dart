import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File yang baru dibuat oleh flutterfire
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Berita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Proyek UTS Berita'),
        ),
        body: Center(
          child: Text('Setup Awal Selesai!'),
        ),
      ),
    );
  }
}