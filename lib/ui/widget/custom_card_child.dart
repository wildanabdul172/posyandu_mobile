import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/ui/pages/child_history_page.dart';

import '../../shared/theme.dart';

class CustomCardChild extends StatelessWidget {
  final String childId;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String address;
  final String parentName;
  final String parentPhoneNumber;
  final String userId;
  const CustomCardChild({
    super.key,
    required this.childId,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.userId,
  });

  String calculateAge(String dateOfBirthString) {
    final dateFormat = DateFormat('dd MMMM yy');
    final dateOfBirth = dateFormat.parse(dateOfBirthString);
    final currentDate = DateTime.now();
    int ageInYears = currentDate.year - dateOfBirth.year;
    int monthDiff = currentDate.month - dateOfBirth.month;
    int dayDiff = currentDate.day - dateOfBirth.day;

    // Jika tanggal lahir di bulan yang sama atau belum melewati hari ulang tahun
    if (monthDiff < 0 || (monthDiff == 0 && dayDiff < 0)) {
      ageInYears--;
      monthDiff += 12; // Menambahkan 12 bulan agar selisih positif
    }

    String ageText = '$ageInYears Tahun';
    if (monthDiff > 0) {
      ageText += ' $monthDiff Bulan';
    }

    return ageText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChildHistoryPage(
              name: name,
              childId: childId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(
          10,
        ),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 8),
              color: kGreyColor,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.child_care_rounded,
              color: kBlueColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    calculateAge(dateOfBirth),
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: kBlackColor,
            ),
          ],
        ),
      ),
    );
  }
}
