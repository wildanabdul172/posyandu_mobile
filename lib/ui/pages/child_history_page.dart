import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/models/history_child_model.dart';
import 'package:posyandu/services/history_child_services.dart';
import 'package:posyandu/ui/widget/custom_card_History.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../shared/theme.dart';
import '../widget/custom_icons.dart';

enum MeasurementType {
  tinggiBadan,
  beratBadan,
  lingkarLengan,
  lingkarKepala,
}

class ChildHistoryPage extends StatefulWidget {
  final String childId;
  final String name;
  const ChildHistoryPage({
    super.key,
    required this.childId,
    required this.name,
  });

  @override
  State<ChildHistoryPage> createState() => _ChildHistoryPageState();
}

class _ChildHistoryPageState extends State<ChildHistoryPage> {
  MeasurementType _selectedMeasurementType = MeasurementType.tinggiBadan;
  List<HistoryChildResponseModel> _history = [];

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'id_ID';
    initializeDateFormatting();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      List<HistoryChildResponseModel> historyData =
          await HistoryChildService.fetchHistory();
      historyData.sort((a, b) => b.dateOfRecord!.compareTo(a.dateOfRecord!));
      setState(() {
        _history = historyData;
      });
    } catch (e) {
      print('Failed to fetch history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.transparent,
          leading: IconButtonBack(color: kBlueColor),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: kWhiteColor,
            ),
          ),
          title: Image.asset(
            "assets/images/Posyandu_Logo_Blue_Icon.png",
            width: 40,
            height: 40,
          ),
        ),
        SliverToBoxAdapter(
            child: SingleChildScrollView(
                child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tumbuh Kembang Anak",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Raka Al mair",
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildChart(),
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMeasurementType = MeasurementType.tinggiBadan;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMeasurementType ==
                              MeasurementType.tinggiBadan
                          ? kBlueColor
                          : kWhiteColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Tinggi Badan',
                      style: TextStyle(
                        color: _selectedMeasurementType ==
                                MeasurementType.tinggiBadan
                            ? kWhiteColor
                            : kBlackColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMeasurementType = MeasurementType.beratBadan;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedMeasurementType == MeasurementType.beratBadan
                              ? kBlueColor
                              : kWhiteColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Berat Badan',
                      style: TextStyle(
                        color: _selectedMeasurementType ==
                                MeasurementType.beratBadan
                            ? kWhiteColor
                            : kBlackColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMeasurementType =
                            MeasurementType.lingkarLengan;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMeasurementType ==
                              MeasurementType.lingkarLengan
                          ? kBlueColor
                          : kWhiteColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Lingkar Lengan',
                      style: TextStyle(
                        color: _selectedMeasurementType ==
                                MeasurementType.lingkarLengan
                            ? kWhiteColor
                            : kBlackColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedMeasurementType =
                            MeasurementType.lingkarKepala;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedMeasurementType ==
                              MeasurementType.lingkarKepala
                          ? kBlueColor
                          : kWhiteColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Lingkar Kepala',
                      style: TextStyle(
                        color: _selectedMeasurementType ==
                                MeasurementType.lingkarKepala
                            ? kWhiteColor
                            : kBlackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < _history.length; i++)
              CustomCardHistory(
                tanggal: _history[i].dateOfRecord,
                tBadan: _history[i].height.toString(),
                bBadan: _history[i].weight.toString(),
                lLengan: _history[i].armCircumference.toString(),
                lKepala: _history[i].headCircumference.toString(),
                imunisasi: _history[i].immunization,
              ),
          ],
        )))
      ]),
    );
  }

  Widget _buildChart() {
    List<DataPoint> dataPoints = [];

    switch (_selectedMeasurementType) {
      case MeasurementType.tinggiBadan:
        dataPoints = _history.map((history) {
          final date =
              DateFormat('dd MMMM yyyy', 'id_ID').parse(history.dateOfRecord!);
          final month = DateFormat('MMMM', 'id_ID').format(date);
          return DataPoint(x: month, y: history.height!);
        }).toList();
        break;
      case MeasurementType.beratBadan:
        dataPoints = _history.map((history) {
          final date =
              DateFormat('dd MMMM yyyy', 'id_ID').parse(history.dateOfRecord!);
          final month = DateFormat('MMMM', 'id_ID').format(date);
          return DataPoint(x: month, y: history.weight!);
        }).toList();
        break;
      case MeasurementType.lingkarLengan:
        dataPoints = _history.map((history) {
          final date =
              DateFormat('dd MMMM yyyy', 'id_ID').parse(history.dateOfRecord!);
          final month = DateFormat('MMMM', 'id_ID').format(date);
          return DataPoint(x: month, y: history.armCircumference!);
        }).toList();
        break;
      case MeasurementType.lingkarKepala:
        dataPoints = _history.map((history) {
          final date =
              DateFormat('dd MMMM yyyy', 'id_ID').parse(history.dateOfRecord!);
          final month = DateFormat('MMMM', 'id_ID').format(date);
          return DataPoint(x: month, y: history.headCircumference!);
        }).toList();
        break;
    }

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <LineSeries<DataPoint, String>>[
        LineSeries<DataPoint, String>(
          dataSource: dataPoints,
          xValueMapper: (DataPoint data, _) => data.x,
          yValueMapper: (DataPoint data, _) => data.y,
          color: kBlueColor,
        ),
      ],
    );
  }
}

class DataPoint {
  final String x;
  final int y;

  DataPoint({required this.x, required this.y});
}
