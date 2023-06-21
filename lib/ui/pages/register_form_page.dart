import 'package:flutter/material.dart';
import 'package:posyandu/shared/theme.dart';

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
                          "Tumbuh Kembang Anak",
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Posyandu Anggrek",
                        style: whiteTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Form Pendaftaran",
                        style: blackTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 14),
                      ),
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nama Anak',
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nama Anak';
                        }
                        return null;
                      },
                      onSaved: null,
                    ),
                    CustomTextFormDate(
                        title: "Tanggal Lahir",
                        icon: Icons.calendar_month_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong Isi Nama Anak';
                          }
                          return null;
                        },
                        onSaved: null),
                    CustomTextFormDropDown(
                      title: "Jenis Kelamin",
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nama Anak';
                        }
                        return null;
                      },
                      onSaved: null,
                      dropdownValues: const [
                        "Laki-Laki",
                        "Perempuan",
                      ],
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Alamat',
                      icon: Icons.location_on,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Alamat';
                        }
                        return null;
                      },
                      onSaved: null,
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nama Orang Tua',
                      icon: Icons.account_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nama Orang Tua';
                        }
                        return null;
                      },
                      onSaved: null,
                    ),
                    CustomTextForm(
                      obsecureText: false,
                      title: 'Nomor Telepon Orang Tua',
                      icon: Icons.phone_android,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tolong Isi Nomor Telepon Orang Tua';
                        }
                        return null;
                      },
                      onSaved: null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtonAuth(
                      title: 'Daftar',
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                        }
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
