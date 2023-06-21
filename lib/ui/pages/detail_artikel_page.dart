import 'package:flutter/material.dart';
import 'package:posyandu/shared/theme.dart';

import '../widget/custom_icons.dart';

class DetailArtikelPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String date;
  const DetailArtikelPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButtonBack(color: kBlueColor),
            centerTitle: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: kWhiteColor,
              ),
            ),
            title: Text(
              "Artikel",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            title,
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          date,
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          content,
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
