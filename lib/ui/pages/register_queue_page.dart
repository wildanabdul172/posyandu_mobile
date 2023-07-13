import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posyandu/models/children_model.dart';
import 'package:posyandu/models/queue_model.dart';
import 'package:posyandu/services/children_services.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/schedule_model.dart';
import '../../services/register_services.dart';
import '../widget/custom_button_auth.dart';
import '../widget/custom_icons.dart';
import '../widget/custom_textform.dart';

class RegisterQueuePage extends StatefulWidget {
  final int? activityId;
  final String? activityName;
  final String? activityDate;
  final String? activityTime;
  final int? activityLocation;
  final PosyanduSchedule? posyandu;

  const RegisterQueuePage({
    super.key,
    required this.activityId,
    required this.activityName,
    required this.activityDate,
    required this.activityTime,
    required this.activityLocation,
    required this.posyandu,
  });

  @override
  State<RegisterQueuePage> createState() => _RegisterQueuePageState();
}

class _RegisterQueuePageState extends State<RegisterQueuePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedChildId;
  late SharedPreferences _prefs;
  String? id;
  List<ChildrenResponseModel> _children = [];

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      id = _prefs.getString('userId');
    });
    _fetchChildren();
  }

  Future<void> _fetchChildren() async {
    try {
      List<ChildrenResponseModel> childrenList =
          await ChildrenService.fetchChildren(id!);
      setState(() {
        _children = childrenList;
      });
    } catch (e) {
      print('Failed to fetch children: $e');
    }
  }

  Future<void> _register() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      final parsedDate =
          DateFormat('EEEE, dd MMMM yyyy', 'id_ID').parse(widget.activityDate!);
      final formattedDate =
          DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(parsedDate);

      final registerData = QueueRequest(
        childId: _selectedChildId,
        date: formattedDate,
        time: widget.activityTime,
        status: "Pending",
        userId: id,
        posyanduId: widget.posyandu!.id,
      );

      final isRegistered = await RegisterService.registerQueue(registerData);

      if (isRegistered) {
        Get.snackbar(
          'Registrasi Berhasil',
          'Anda telah berhasil terdaftar',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 3));
        Get.offNamed('/main');
      } else if (RegisterService.lastStatusCode == 400) {
        Get.snackbar(
          'Registrasi Gagal',
          'Anak sudah terdaftar',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Registrasi Gagal',
          'Anda telah gagal registrasi',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Registrasi gagal');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        leading: IconButtonBack(
          color: kWhiteColor,
        ),
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/Posyandu_Logo_White.png',
          height: 40,
          width: 40,
          // Menambahkan alignment untuk mengatur posisi gambar di tengah
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
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
                          "Pendaftaran Antrian",
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Form Antrian Posyandu ${widget.posyandu!.name}",
                          style: whiteTextStyle.copyWith(
                              fontWeight: semiBold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  children: [
                    CustomTextFormDropDown(
                      title: "Anak",
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Data Anak';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        final selectedChild = _children
                            .firstWhere((child) => child.name == value);
                        _selectedChildId = selectedChild.childId;
                        return null;
                      },
                      dropdownValues:
                          _children.map((child) => child.name).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAuth(
                      title: 'Daftar',
                      onPressed: _register,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
