import 'package:flutter/material.dart';
import 'package:posyandu/ui/widget/carousel_card.dart';
import 'package:posyandu/ui/widget/custom_card_article.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/artikel_model.dart';
import '../../shared/theme.dart';
import '../../services/artikel_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> _articles = [];
  late SharedPreferences _prefs;
  String? name, email;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _fetchArticles();
  }

  void _getUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('name');
      email = _prefs.getString('email');
    });
  }

  Future<void> _fetchArticles() async {
    try {
      List<Article> artikelData = await ArtikelService.fetchArtikel();

      setState(() {
        _articles = artikelData;
      });
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }

  Future<void> _refreshData() async {
    await _fetchArticles();
    const CarouselCardHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kGreyColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 320,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: kBlueColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(
                                20,
                              ),
                              width: 36,
                              height: 36,
                              child: Image.asset(
                                  'assets/images/Posyandu_Logo_White.png'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selamat Datang,",
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Text(
                                  name.toString(),
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 220,
                          child: CarouselCardHome(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                padding: const EdgeInsets.all(
                  20,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                ),
                child: Column(
                  children: [
                    Text(
                      "New Artikel",
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
