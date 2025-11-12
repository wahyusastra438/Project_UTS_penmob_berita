import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; 

class AppOnboardingScreen extends StatelessWidget {
  const AppOnboardingScreen({super.key});

  void _onOnboardingDone(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Berita Terbaru, Setiap Saat",
          body: "Dapatkan akses instan ke berita utama dari seluruh dunia.",
          image: const Center(child: Icon(Icons.newspaper, size: 100.0)),
        ),
        PageViewModel(
          title: "Personalisasi Penuh",
          body: "Simpan artikel favorit Anda dan ikuti topik yang Anda sukai.",
          image: const Center(child: Icon(Icons.bookmark, size: 100.0)),
        ),
        PageViewModel(
          title: "Notifikasi Instan",
          body: "Jangan pernah ketinggalan berita penting dengan notifikasi real-time.",
          image: const Center(child: Icon(Icons.notifications, size: 100.0)),
        ),
      ],
      onDone: () => _onOnboardingDone(context),
      done: const Text("Selesai", style: TextStyle(fontWeight: FontWeight.w600)),
      
      showSkipButton: true,
      onSkip: () => _onOnboardingDone(context), // Skip juga dianggap selesai
      skip: const Text("Lewati"),

      next: const Icon(Icons.arrow_forward),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}