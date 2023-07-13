import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/ui/widget/custom_card_queue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/queue_model.dart';
import '../../models/schedule_model.dart';
import '../../services/queue_services.dart';
import '../../services/schedule_service.dart';
import '../../shared/theme.dart';
import '../widget/carousel_card.dart';
import '../widget/schedule_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Schedule> _scheduleList = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
    _fetchSchedule();
  }

  Future<void> _onRefresh() async {
    _fetchSchedule();
  }

  Future<void> _fetchSchedule() async {
    try {
      List<Schedule> scheduleData = await ScheduleService.fetchSchedule();
      scheduleData.sort((a, b) => b.activityDate!.compareTo(a.activityDate!));
      setState(() {
        _scheduleList = scheduleData;
      });
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kGreyColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/Posyandu_Logo_White.png',
          height: 40,
          width: 40,
          alignment: Alignment.center,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 380,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: Text(
                            "Pendaftaran Online",
                            style: whiteTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 220,
                          child: CarouselCardSchedule(),
                          // child: CarouselSlider(
                          //   options: CarouselOptions(
                          //     height: 180,
                          //     viewportFraction: 0.8,
                          //     enableInfiniteScroll: false,
                          //   ),
                          //   items: [
                          //     for (int i = 0; i < _queueUser.length; i++)
                          //       CustomCardQueueUser(
                          //         name: _queueUser[i].child?.name,
                          //         date: _queueUser[i].dateOfQueue,
                          //         location:
                          //             _queueUser[i].posyandu?.posyanduName,
                          //         queue: _queueUser[i].queueNumber.toString(),
                          //       ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Flamboyan",
                          //       address: 'Kp.Pangkalan RT 05 RW 02',
                          //       queue: _queueFlamboyan.isNotEmpty
                          //           ? _queueFlamboyan[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Melati 1",
                          //       address: 'Kp.Babakan RT 03 RW 01',
                          //       queue: _queueMelatiOne.isNotEmpty
                          //           ? _queueMelatiOne[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Melati 2",
                          //       address: 'Kp.Babakan RT 11 RW 03',
                          //       queue: _queueMelatiTwo.isNotEmpty
                          //           ? _queueMelatiTwo[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Mawar",
                          //       address: 'Kp.Liungtutut RT 18 RW 08',
                          //       queue: _queueMawar.isNotEmpty
                          //           ? _queueMawar[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Dahlia",
                          //       address: 'Kp.Bojongnangka RT 25 RW 07',
                          //       queue: _queueDahlia.isNotEmpty
                          //           ? _queueDahlia[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Kaca Piring 1",
                          //       address: 'Perum Babakan RT RW 10',
                          //       queue: _queueKacaPiringOne.isNotEmpty
                          //           ? _queueKacaPiringOne[0]
                          //               .queueNumber
                          //               .toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Kaca Piring 2",
                          //       address: 'Perum Babakan RT RW 10',
                          //       queue: _queueKacaPiringTwo.isNotEmpty
                          //           ? _queueKacaPiringTwo[0]
                          //               .queueNumber
                          //               .toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Anggrek",
                          //       address: 'Kp.Padurenan RT 27 RW 09',
                          //       queue: _queueAnggrek.isNotEmpty
                          //           ? _queueAnggrek[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Kenanga 1",
                          //       address: 'Kp.Gunungguruh Girang RT 14 RW 04',
                          //       queue: _queueKenangaOne.isNotEmpty
                          //           ? _queueKenangaOne[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //     CustomCardQueuePosyandu(
                          //       date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                          //           .format(DateTime.now()),
                          //       location: "Posyandu Kenanga 2",
                          //       address: 'Kp.Gunungguruh Girang RT 13 RW 04',
                          //       queue: _queueKenangaTwo.isNotEmpty
                          //           ? _queueKenangaTwo[0].queueNumber.toString()
                          //           : '-',
                          //     ),
                          //   ],
                          // ),
                        ),
                        Text(
                          "Jadwal Posyandu",
                          style: blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              for (int i = 0; i < _scheduleList.length; i++)
                ScheduleCard(
                  activityId: _scheduleList[i].activityId!,
                  activityName: _scheduleList[i].activityName!,
                  activityDate: _scheduleList[i].activityDate!,
                  activityTime: _scheduleList[i].activityTime!,
                  activityLocation: _scheduleList[i].activityLocation!,
                  posyandu: _scheduleList[i].posyandu!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
