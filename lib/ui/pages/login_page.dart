import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/ui/widget/custom_button_auth.dart';
import 'package:posyandu/ui/widget/custom_textform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/login_model.dart';
import '../../services/login_services.dart';
import '../../shared/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  void _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _saveLoginSession(
    String userId,
    String name,
    String email,
    String phoneNumber,
  ) {
    _prefs.setString('userId', userId);
    _prefs.setString('name', name);
    _prefs.setString('email', email);
    _prefs.setString('phone_number', phoneNumber);
    _prefs.setBool('isLoggedIn', true);
    _prefs.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _login() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      if (_formKey.currentState!.validate()) {
        // Panggil fungsi login dari LoginService
        final LoginRequestModel requestModel =
            LoginRequestModel(email: email, password: password);
        try {
          final LoginResponseModel response =
              await _loginService.login(requestModel);
          if (response.userId != null) {
            Get.snackbar(
              'Login Berhasil',
              'Anda telah berhasil login',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            _saveLoginSession(response.userId.toString(), response.name!,
                response.email!, response.phoneNumber!);
            await Future.delayed(const Duration(seconds: 3));
            Get.offNamed('/main');
          } else {
            Get.snackbar(
              'Login Gagal',
              'Email atau password salah',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Login Gagal',
            'Email atau password salah',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print(e);
        }
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
                  "Masuk\nKe Akun Anda",
                  style: blackTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 14),
                ),
              ),
              CustomTextForm(
                obsecureText: false,
                title: 'Email',
                controller: _emailController,
                icon: Icons.email_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
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
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) => _passwordController.text = value!,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonAuth(
                title: 'Masuk',
                onPressed: () {
                  _login();
                },
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/register');
                },
                child: Text(
                  "Buat Akun Baru",
                  style: greyTextStyle.copyWith(fontSize: 14, fontWeight: bold),
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
