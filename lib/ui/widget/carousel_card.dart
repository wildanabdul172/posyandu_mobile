import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/artikel_model.dart';
import '../../services/artikel_services.dart';
import '../../shared/theme.dart';

class CarouselCardHome extends StatefulWidget {
  const CarouselCardHome({Key? key}) : super(key: key);

  @override
  State<CarouselCardHome> createState() => _CarouselCardHomeState();
}

class _CarouselCardHomeState extends State<CarouselCardHome> {
  List<Article> _articles = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      List<Article> artikelData = await ArtikelService.fetchArtikel();
      setState(() {
        _articles = artikelData.take(5).toList();
      });
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: _articles
                .map((article) => CarouselTemplate(
                      imageUrl: 'http://192.168.1.9:4400/${article.image!}',
                      title: article.title!,
                    ))
                .toList(),
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _articles.length && i < 5; i++)
              GestureDetector(
                onTap: () => _controller.animateToPage(i),
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == i ? 0.9 : 0.4),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}

class CarouselTemplate extends StatelessWidget {
  final String imageUrl;
  final String title;
  const CarouselTemplate({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor.withOpacity(0.75),
          ),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
