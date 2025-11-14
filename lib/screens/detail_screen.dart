import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart'; 

class DetailScreen extends StatelessWidget {
  final ArticleModel article;

  const DetailScreen({super.key, required this.article});

  Future<void> _launchURL() async {
    if (article.url != null) {
      final Uri uri = Uri.parse(article.url!);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $uri');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "Detail Berita"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage!,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text("Gagal memuat gambar"));
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                article.title ?? "Judul tidak tersedia",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                article.description ?? "Deskripsi tidak tersedia",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                article.content ?? "Konten tidak tersedia",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20), 

              if (article.url != null)
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text("Baca Selengkapnya"),
                    onPressed: _launchURL, 
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}