import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/news_provider.dart'; 
import '../models/article_model.dart'; 
import 'detail_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda Berita"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.signOut();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Selamat Datang, ${user?.displayName ?? user?.email}!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, newsProvider, child) {
                switch (newsProvider.status) {
                  case NewsStatus.loading:
                  case NewsStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case NewsStatus.error:
                    return Center(child: Text("Error: ${newsProvider.errorMessage}"));
                  case NewsStatus.loaded:
                    return _buildArticleList(newsProvider.articles);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList(List<ArticleModel> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(article.title ?? "Tanpa Judul"),
            subtitle: Text(article.description ?? "", maxLines: 2, overflow: TextOverflow.ellipsis),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(article: article),
                ),
              );
            },
          ),
        );
      },
    );
  }
}