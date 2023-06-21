import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/models/register_model.dart';
import 'package:posyandu/services/register_services.dart';

import '../../shared/theme.dart';
import '../widget/custom_button_auth.dart';
import '../widget/custom_textform.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _register() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      final registerData = Register(
        fullname: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        address: _addressController.text,
        phoneNumber: _phoneNumberController.text,
      );

      final isRegistered = await RegisterService.register(registerData);

      if (isRegistered) {
        Get.snackbar(
          'Registrasi Berhasil',
          'Anda telah berhasil terdaftar',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await Future.delayed(const Duration(seconds: 3));
        Get.toNamed('/login');
      } else if (RegisterService.lastStatusCode == 400) {
        Get.snackbar(
          'Registrasi Gagal',
          'Email sudah terdaftar',
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
    Widget body() {
      return Container(
        margin: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/Posyandu_Logo_Blue.png',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 54),
                child: Column(
                  children: [
                    Text(
                      "POSYANDU",
                      style: blueTextStyle.copyWith(
                        fontSize: 40,
                        fontWeight: black,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Mobile",
                        style: blueTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Buat\nAkun Baru",
                  style: blackTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 14),
                ),
              ),
              CustomTextForm(
                obsecureText: false,
                title: 'Nama Lengkap',
                controller: _nameController,
                icon: Icons.account_circle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Isi Nama Lengkap';
                  }
                  return null;
                },
                onSaved: (value) => _nameController.text = value!,
              ),
              CustomTextForm(
                obsecureText: false,
                title: 'Email',
                controller: _emailController,
                icon: Icons.email_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Isi Email';
                  }
                  return null;
                },
                onSaved: (value) => _emailController.text = value!,
              ),
              CustomTextForm(
                obsecureText: true,
                title: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Isi Password';
                  }
                  return null;
                },
                onSaved: (value) => _passwordController.text = value!,
              ),
              CustomTextForm(
                obsecureText: false,
                title: 'Alamat',
                controller: _addressController,
                icon: Icons.location_on,
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
                title: 'Nomor Telepon',
                controller: _phoneNumberController,
                icon: Icons.phone_android,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Isi Nomor Telepon';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumberController.text = value!,
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
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Text(
                  "Masuk ke Akun Anda",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: body(),
        ),
      ),
    );
  }
}
