import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/models/children_model.dart';
import 'package:posyandu/services/children_services.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_button_auth.dart';
import '../widget/custom_icons.dart';
import '../widget/custom_textform.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneNumberController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedGender;
  late SharedPreferences _prefs;
  String? id;

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
  }

  Future<void> _register() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      final dateParts = _dateController.text.split('/');
      final formattedDate = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
      ).toIso8601String();

      final registerData = ChildrenRequestModel(
        name: _nameController.text,
        birtOfDate: formattedDate,
        gender: _selectedGender,
        address: _addressController.text,
        parentName: _parentNameController.text,
        parentPhoneNumber: _parentPhoneNumberController.text,
        userId: id,
      );

      final isRegistered = await ChildrenService.register(registerData);

      if (isRegistered) {
        Get.snackbar(
          'Registrasi Berhasil',
          'Anda telah mendaftar data anak',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 3));
        Get.toNamed('/main');
      } else if (ChildrenService.lastStatusCode == 400) {
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
                          "Tambah Data Anak",
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
                          "Form Pendaftaran",
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
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nama Anak',
                      icon: Icons.account_circle,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nama Anak';
                        }
                        return null;
                      },
                      onSaved: (value) => _nameController.text = value!,
                    ),
                    CustomTextFormDate(
                      title: "Tanggal Lahir",
                      icon: Icons.calendar_month_rounded,
                      controller: _dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Tanggal Lahir';
                        }
                        return null;
                      },
                      onSaved: (value) => _dateController.text = value!,
                    ),
                    CustomTextFormDropDown(
                      title: "Jenis Kelamin",
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Jenis Kelamin';
                        }
                        return null;
                      },
                      onSaved: (value) => _selectedGender = value!,
                      dropdownValues: const [
                        "Laki-Laki",
                        "Perempuan",
                      ],
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Alamat',
                      icon: Icons.location_on,
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Alamat';
                        }
                        return null;
                      },
                      onSaved: (value) => _addressController.text = value!,
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nama Orang Tua',
                      icon: Icons.account_circle,
                      controller: _parentNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nama Orang Tua';
                        }
                        return null;
                      },
                      onSaved: (value) => _parentNameController.text = value!,
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nomor Telepon Orang Tua',
                      icon: Icons.phone_android,
                      controller: _parentPhoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nomor Telepon Orang Tua';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          _parentPhoneNumberController.text = value!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAuth(
                      title: 'Daftar',
                      onPressed: () {
                        _register();
                      },
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
