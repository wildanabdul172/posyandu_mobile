import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomCardChild extends StatelessWidget {
  final String name;
  final String umur;
  const CustomCardChild({
    super.key,
    required this.name,
    required this.umur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  umur,
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
    );
  }
}
