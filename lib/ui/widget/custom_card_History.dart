import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomCardHistory extends StatelessWidget {
  final String? tanggal;
  final String? tBadan;
  final String? bBadan;
  final String? lKepala;
  final String? lLengan;
  final String? imunisasi;
  const CustomCardHistory({
    super.key,
    this.tanggal,
    this.tBadan,
    this.bBadan,
    this.lKepala,
    this.lLengan,
    this.imunisasi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(
        20,
      ),
      padding: const EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: kBlueColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Tanggal",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  tanggal!,
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Tinggi Badan",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  '${tBadan!} cm',
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Berat Badan",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  '${bBadan!} kg',
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Lingkar Kepala",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  '${lKepala!} cm',
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Lingkar Lengan",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  '${lLengan!} cm',
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Imunisasi",
                style:
                    whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
              Expanded(
                child: Text(
                  imunisasi!,
                  textAlign: TextAlign.end,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
