import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/artikel_model.dart';
import '../../models/queue_model.dart';
import '../../services/artikel_services.dart';
import '../../services/queue_services.dart';
import '../../shared/theme.dart';
import 'custom_card_queue.dart';

class CarouselCardHome extends StatefulWidget {
  const CarouselCardHome({Key? key}) : super(key: key);

  @override
  State<CarouselCardHome> createState() => _CarouselCardHomeState();
}

class _CarouselCardHomeState extends State<CarouselCardHome> {
  List<Article> _articles = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      List<Article> artikelData = await ArtikelService.fetchArtikel();
      setState(() {
        _articles = artikelData.take(5).toList();
      });
    } catch (e) {
      print('Failed to fetch articles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: _articles
                .map((article) => CarouselTemplate(
                      imageUrl: 'https://barrxyz.com/${article.image!}',
                      title: article.title!,
                    ))
                .toList(),
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _articles.length && i < 5; i++)
              GestureDetector(
                onTap: () => _controller.animateToPage(i),
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == i ? 0.9 : 0.4),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}

class CarouselTemplate extends StatelessWidget {
  final String imageUrl;
  final String title;
  const CarouselTemplate({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: kWhiteColor.withOpacity(0.75),
          ),
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CarouselCardSchedule extends StatefulWidget {
  const CarouselCardSchedule({
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselCardSchedule> createState() => _CarouselCardScheduleState();
}

class _CarouselCardScheduleState extends State<CarouselCardSchedule> {
  List<QueueResponse> _queueUser = [];
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
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String? userId;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID');
    _getUserData();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: [
              for (int i = 0; i < _queueUser.length; i++)
                CustomCardQueueUser(
                  name: _queueUser[i].child?.name,
                  date: _queueUser[i].dateOfQueue,
                  location: _queueUser[i].posyandu?.posyanduName,
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
                    ? _queueKacaPiringOne[0].queueNumber.toString()
                    : '-',
              ),
              CustomCardQueuePosyandu(
                date: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                    .format(DateTime.now()),
                location: "Posyandu Kaca Piring 2",
                address: 'Perum Babakan RT RW 10',
                queue: _queueKacaPiringTwo.isNotEmpty
                    ? _queueKacaPiringTwo[0].queueNumber.toString()
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
            ].map((widget) => widget).toList(),
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _queueUser.length + 10; i++)
              GestureDetector(
                onTap: () => _controller.animateToPage(i),
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == i ? 0.9 : 0.4),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
