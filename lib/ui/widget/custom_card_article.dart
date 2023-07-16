import 'package:flutter/material.dart';
import 'package:posyandu/ui/pages/detail_artikel_page.dart';
import '../../shared/theme.dart';

class CustomCardArticle extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;
  final String date;
  const CustomCardArticle({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikelPage(
              imageUrl: 'http://192.168.20.23:4400/$imageUrl',
              title: title,
              content: content,
              date: date,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 5,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              margin: const EdgeInsets.only(
                right: 10,
              ),
              width: 80,
              child: Image.network(
                'http://192.168.20.23:4400/$imageUrl',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 225,
                  height: 37,
                  child: Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Text(
                  date,
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: regular,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
