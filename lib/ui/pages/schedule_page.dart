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
import '../widget/schedule_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<QueueResponse> _queueFlamboyan = [];
  List<QueueResponse> _queueMelatiOne = [];
  List<QueueResponse> _queueMelatiTwo = [];
  List<QueueResponse> _queueMawar = [];
  List<QueueResponse> _queueDahlia = [];
  List<QueueResponse> _queueKacaPiringOne = [];
  List<QueueResponse> _queueKacaPiringTwo = [];
  List<QueueResponse> _queueAnggrek = [];
  List<QueueResponse> _queueKenangaOne = [];
  List<QueueResponse> _queueKenangaTwo = [];
  List<Schedule> _scheduleList = [];
  late SharedPreferences _prefs;
  List<QueueResponse> _queueUser = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
    _getUserData();
    _fetchSchedule();
    _fetchQueueDahlia();
    _fetchQueueFlamboyan();
    _fetchQueueMelatiOne();
    _fetchQueueMelatiTwo();
    _fetchQueueMawar();
    _fetchQueueKacaPiringOne();
    _fetchQueueKacaPiringTwo();
    _fetchQueueAnggrek();
    _fetchQueueKenangaOne();
    _fetchQueueKenangaTwo();
  }

  Future<void> _onRefresh() async {
    _fetchSchedule();
    _fetchQueueDahlia();
    _fetchQueueFlamboyan();
    _fetchQueueMelatiOne();
    _fetchQueueMelatiTwo();
    _fetchQueueMawar();
    _fetchQueueKacaPiringOne();
    _fetchQueueKacaPiringTwo();
    _fetchQueueAnggrek();
    _fetchQueueKenangaOne();
    _fetchQueueKenangaTwo();

    setState(() {
      _scheduleList = [];
      _queueFlamboyan = [];
      _queueMelatiOne = [];
      _queueMelatiTwo = [];
      _queueMawar = [];
      _queueDahlia = [];
      _queueKacaPiringOne = [];
      _queueKacaPiringTwo = [];
      _queueAnggrek = [];
      _queueKenangaOne = [];
      _queueKenangaTwo = [];
    });
  }

  void _getUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = _prefs.getString('userId');
    });
    _fetchQueuebyUserId();
  }

  Future<void> _fetchQueueDahlia() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(5);

      setState(() {
        _queueDahlia = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueFlamboyan() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(1);

      setState(() {
        _queueFlamboyan = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueMelatiOne() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(2);

      setState(() {
        _queueMelatiOne = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueMelatiTwo() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(3);

      setState(() {
        _queueMelatiTwo = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueMawar() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(4);

      setState(() {
        _queueMawar = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueKacaPiringOne() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(6);

      setState(() {
        _queueKacaPiringOne = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueKacaPiringTwo() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(7);

      setState(() {
        _queueKacaPiringTwo = [queueData];
        print(_queueKacaPiringTwo[0]);
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueAnggrek() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(8);

      setState(() {
        _queueAnggrek = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueKenangaOne() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(9);

      setState(() {
        _queueKenangaOne = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueueKenangaTwo() async {
    try {
      QueueResponse queueData = await QueueService.getQueueData(10);

      setState(() {
        _queueKenangaTwo = [queueData];
      });
    } catch (e) {
      print('Failed to fetch Queue: $e');
    }
  }

  Future<void> _fetchQueuebyUserId() async {
    try {
      List<QueueResponse> queueData =
          await QueueService.fetchQueueByUserId(userId!);

      // Filter data berdasarkan hari ini
      DateTime today = DateTime.now();
      List<QueueResponse> todayQueue = queueData.where((queue) {
        // Parsing tanggal dari string menjadi objek DateTime
        DateTime queueDate =
            DateFormat('EEEE, dd MMMM yyyy', 'id_ID').parse(queue.dateOfQueue!);

        // Bandingkan tanggal dengan tanggal hari ini
        return queueDate.year == today.year &&
            queueDate.month == today.month &&
            queueDate.day == today.day;
      }).toList();

      setState(() {
        _queueUser = todayQueue;
      });
    } catch (e) {
      print('Failed to fetch Queue By User Id: $e');
    }
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
                    height: 340,
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
                        SizedBox(
                          height: 180,
                          child: ListView(
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 0; i < _queueUser.length; i++)
                                CustomCardQueueUser(
                                  name: _queueUser[i].child?.name,
                                  date: _queueUser[i].dateOfQueue,
                                  location:
                                      _queueUser[i].posyandu?.posyanduName,
                                  queue: _queueUser[i].queueNumber.toString(),
                                ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Flamboyan",
                                address: 'Kp.Pangkalan RT 05 RW 02',
                                queue: _queueFlamboyan.isNotEmpty
                                    ? _queueFlamboyan[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Melati 1",
                                address: 'Kp.Babakan RT 03 RW 01',
                                queue: _queueMelatiOne.isNotEmpty
                                    ? _queueMelatiOne[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Melati 2",
                                address: 'Kp.Babakan RT 11 RW 03',
                                queue: _queueMelatiTwo.isNotEmpty
                                    ? _queueMelatiTwo[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Mawar",
                                address: 'Kp.Liungtutut RT 18 RW 08',
                                queue: _queueMawar.isNotEmpty
                                    ? _queueMawar[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Dahlia",
                                address: 'Kp.Bojongnangka RT 25 RW 07',
                                queue: _queueDahlia.isNotEmpty
                                    ? _queueDahlia[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Kaca Piring 1",
                                address: 'Perum Babakan RT RW 10',
                                queue: _queueKacaPiringOne.isNotEmpty
                                    ? _queueKacaPiringOne[0]
                                        .queueNumber
                                        .toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Kaca Piring 2",
                                address: 'Perum Babakan RT RW 10',
                                queue: _queueKacaPiringTwo.isNotEmpty
                                    ? _queueKacaPiringTwo[0]
                                        .queueNumber
                                        .toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Anggrek",
                                address: 'Kp.Padurenan RT 27 RW 09',
                                queue: _queueAnggrek.isNotEmpty
                                    ? _queueAnggrek[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Kenanga 1",
                                address: 'Kp.Gunungguruh Girang RT 14 RW 04',
                                queue: _queueKenangaOne.isNotEmpty
                                    ? _queueKenangaOne[0].queueNumber.toString()
                                    : '-',
                              ),
                              CustomCardQueuePosyandu(
                                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                                    .format(DateTime.now()),
                                location: "Posyandu Kenanga 2",
                                address: 'Kp.Gunungguruh Girang RT 13 RW 04',
                                queue: _queueKenangaTwo.isNotEmpty
                                    ? _queueKenangaTwo[0].queueNumber.toString()
                                    : '-',
                              ),
                            ],
                          ),
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
