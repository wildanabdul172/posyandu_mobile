import 'package:flutter/material.dart';
import 'package:posyandu/ui/widget/custom_card_History.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../shared/theme.dart';

enum MeasurementType {
  tinggiBadan,
  beratBadan,
  lingkarLengan,
  lingkarKepala,
}

class ChildHistoryPage extends StatefulWidget {
  const ChildHistoryPage({Key? key}) : super(key: key);

  @override
  State<ChildHistoryPage> createState() => _ChildHistoryPageState();
}

class _ChildHistoryPageState extends State<ChildHistoryPage> {
  MeasurementType _selectedMeasurementType = MeasurementType.tinggiBadan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.transparent,
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
              padding: EdgeInsets.symmetric(vertical: 10),
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
            const CustomCardHistory(
              tanggal: "3 Februari 2023",
              tBadan: "60",
              bBadan: "10",
              lLengan: "4",
              lKepala: "10",
              imunisasi: "Campak",
            ),
            const CustomCardHistory(
              tanggal: "3 Februari 2023",
              tBadan: "60",
              bBadan: "10",
              lLengan: "4",
              lKepala: "10",
              imunisasi: "Campak",
            ),
            const CustomCardHistory(
              tanggal: "3 Februari 2023",
              tBadan: "60",
              bBadan: "10",
              lLengan: "4",
              lKepala: "10",
              imunisasi: "Campak",
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
        dataPoints = [
          DataPoint(x: 'Jan', y: 60),
          DataPoint(x: 'Feb', y: 65),
          DataPoint(x: 'Mar', y: 70),
          DataPoint(x: 'Apr', y: 72),
          DataPoint(x: 'May', y: 75),
          DataPoint(x: 'Jun', y: 78),
        ];
        break;
      case MeasurementType.beratBadan:
        dataPoints = [
          DataPoint(x: 'Jan', y: 10),
          DataPoint(x: 'Feb', y: 12),
          DataPoint(x: 'Mar', y: 15),
          DataPoint(x: 'Apr', y: 18),
          DataPoint(x: 'May', y: 20),
          DataPoint(x: 'Jun', y: 22),
        ];
        break;
      case MeasurementType.lingkarLengan:
        dataPoints = [
          DataPoint(x: 'Jan', y: 4),
          DataPoint(x: 'Feb', y: 4.5),
          DataPoint(x: 'Mar', y: 5),
          DataPoint(x: 'Apr', y: 5.5),
          DataPoint(x: 'May', y: 6),
          DataPoint(x: 'Jun', y: 6.5),
        ];
        break;
      case MeasurementType.lingkarKepala:
        dataPoints = [
          DataPoint(x: 'Jan', y: 10),
          DataPoint(x: 'Feb', y: 11),
          DataPoint(x: 'Mar', y: 12),
          DataPoint(x: 'Apr', y: 13),
          DataPoint(x: 'May', y: 14),
          DataPoint(x: 'Jun', y: 15),
        ];
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
  final double y;

  DataPoint({required this.x, required this.y});
}
