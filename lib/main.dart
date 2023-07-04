import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:posyandu/ui/pages/artikel_page.dart';
import 'package:posyandu/ui/pages/child_page.dart';
import 'package:posyandu/ui/pages/home_page.dart';
import 'package:posyandu/ui/pages/login_page.dart';
import 'package:posyandu/ui/pages/main_page.dart';
import 'package:posyandu/ui/pages/register_form_page.dart';
import 'package:posyandu/ui/pages/register_page.dart';
import 'package:posyandu/ui/pages/schedule_page.dart';
import 'package:posyandu/ui/pages/started_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/profile_page.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  Future<void> setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      int? loginTime = await checkLoginTime();
      if (loginTime != null) {
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        const int logoutDuration = 3600000;
        if (currentTime - loginTime >= logoutDuration) {
          isLoggedIn = false;
          prefs.remove('userId');
          prefs.remove('name');
          prefs.remove('email');
        }
      }
    }
    return isLoggedIn;
  }

  Future<int?> checkLoginTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? loginTime = prefs.getInt('loginTime');
    return loginTime;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isFirstTime = snapshot.data!;
          if (isFirstTime) {
            setFirstTime();
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: const StartedPage(),
              getPages: [
                GetPage(
                  name: '/',
                  page: () => const StartedPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/login',
                  page: () => const LoginPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/register',
                  page: () => const RegisterPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/main',
                  page: () => MainPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/home',
                  page: () => const HomePage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/child',
                  page: () => const ChildPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/register-form',
                  page: () => const RegisterFormPage(),
                ),
                GetPage(
                  name: '/schedule',
                  page: () => const SchedulePage(),
                ),
                GetPage(
                  name: '/profile',
                  page: () => const ProfilePage(),
                ),
                GetPage(
                  name: '/artikel',
                  page: () => const ArtikelPage(),
                ),
              ],
            );
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: FutureBuilder<bool>(
                future: isLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final isLoggedIn = snapshot.data!;
                    return isLoggedIn ? MainPage() : const LoginPage();
                  } else {
                    return const LoginPage();
                  }
                },
              ),
              getPages: [
                GetPage(
                  name: '/',
                  page: () => const StartedPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/login',
                  page: () => const LoginPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/register',
                  page: () => const RegisterPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/main',
                  page: () => MainPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/home',
                  page: () => const HomePage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/child',
                  page: () => const ChildPage(),
                  transition: Transition.fadeIn,
                ),
                GetPage(
                  name: '/register-form',
                  page: () => const RegisterFormPage(),
                ),
                GetPage(
                  name: '/schedule',
                  page: () => const SchedulePage(),
                ),
                GetPage(
                  name: '/profile',
                  page: () => const ProfilePage(),
                ),
                GetPage(
                  name: '/artikel',
                  page: () => const ArtikelPage(),
                ),
              ],
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
