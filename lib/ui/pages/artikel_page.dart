import 'package:flutter/material.dart';

import '../../models/artikel_model.dart';
import '../../services/artikel_services.dart';
import '../../shared/theme.dart';
import '../widget/custom_card_article.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      List<Article> artikelData = await ArtikelService.fetchArtikel();
      setState(() {
        _articles = artikelData;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch articles: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: RefreshIndicator(
        onRefresh: _fetchArticles,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: kWhiteColor,
                ),
              ),
              title: Image.asset(
                "assets/images/Posyandu_Logo_Blue_Icon.png",
                width: 40,
                height: 40,
              ),
            ),
            SliverToBoxAdapter(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              child: Text(
                                "Artikel",
                                style: blackTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            for (int i = 0; i < _articles.length && i < 5; i++)
                              CustomCardArticle(
                                imageUrl: _articles[i].image!,
                                title: _articles[i].title!,
                                date: _articles[i].createAt!,
                                content: _articles[i].content!,
                              ),
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
