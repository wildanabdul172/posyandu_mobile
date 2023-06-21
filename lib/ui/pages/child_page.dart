import 'package:flutter/material.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:posyandu/ui/widget/custom_card_child.dart';

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/Posyandu_Logo_Blue_Icon.png',
          height: 40,
          width: 40,
          alignment: Alignment.center,
        ),
      ),
      body: Column(
        children: [
          Align(
            child: Text(
              "Data Anak",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomCardChild(
            name: "Raka Al Mair",
            umur: "2 Tahun 3 Bulan",
          ),
          const CustomCardChild(
            name: "Raka Al Mair",
            umur: "2 Tahun 3 Bulan",
          ),
          const CustomCardChild(
            name: "Raka Al Mair",
            umur: "2 Tahun 3 Bulan",
          ),
        ],
      ),
    );
  }
}
