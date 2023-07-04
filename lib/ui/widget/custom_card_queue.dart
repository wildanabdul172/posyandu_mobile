import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class CustomCardQueueUser extends StatelessWidget {
  final String? name;
  final String? date;
  final String? location;
  final String? queue;
  const CustomCardQueueUser(
      {super.key,
      required this.name,
      required this.date,
      required this.location,
      required this.queue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: double.infinity,
      width: 280,
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 8),
            color: kGreyColor,
          ),
        ],
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "Nama",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    name ?? '-',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Jadwal",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    date ?? '-',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Lokasi",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    'Posyandu ${location ?? '-'}',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Antrian Ke",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    queue ?? '-',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardQueuePosyandu extends StatelessWidget {
  final String? date;
  final String? location;
  final String? queue;
  final String? address;
  const CustomCardQueuePosyandu({
    super.key,
    required this.date,
    required this.location,
    required this.queue,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: double.infinity,
      width: 280,
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: kGreyColor,
          ),
        ],
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "Tanggal",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    date!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Lokasi",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    location!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Alamat",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    address!,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  "Antrian Sekarang",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    queue!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
