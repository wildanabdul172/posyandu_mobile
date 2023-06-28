import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:posyandu/ui/pages/register_queue_page.dart';

import '../../models/schedule_model.dart';
import '../../shared/theme.dart';

class ScheduleCard extends StatelessWidget {
  final int? activityId;
  final String? activityName;
  final String? activityDate;
  final String? activityTime;
  final int? activityLocation;
  final PosyanduSchedule? posyandu;

  ScheduleCard({
    super.key,
    required this.activityId,
    required this.activityName,
    required this.activityDate,
    required this.activityTime,
    required this.activityLocation,
    required this.posyandu,
  }) {
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final activityDateTime =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').parse(activityDate!);
    final isDateToday =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(activityDateTime) ==
            DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);

    return Container(
      color: kWhiteColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posyandu ${posyandu?.name}',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              Text(
                activityDate!,
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              )
            ],
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: isDateToday
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterQueuePage(
                            activityId: activityId,
                            activityName: activityName,
                            activityDate: activityDate,
                            activityTime: activityTime,
                            activityLocation: activityLocation!,
                            posyandu: posyandu!,
                          ),
                        ),
                      );
                    }
                  : null,
              style: TextButton.styleFrom(
                backgroundColor: isDateToday ? kBlueColor : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Daftar",
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
