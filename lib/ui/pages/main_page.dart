import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:posyandu/ui/pages/child_page.dart';

import '../../controller/navbar_controller.dart';
import 'artikel_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<Widget> pages = [
    const SchedulePage(),
    const ArtikelPage(),
    HomePage(),
    ChildPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navbarController = Get.put(NavbarController());

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: navbarController.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navbarController.currentIndex.value,
          onTap: (index) => navbarController.changePage(index),
          selectedItemColor: kWhiteColor,
          unselectedItemColor: kGreyColor,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              label: 'Jadwal',
              backgroundColor: kBlueColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.article),
              label: 'Artikel',
              backgroundColor: kBlueColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: kBlueColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.child_care),
              label: 'Anak',
              backgroundColor: kBlueColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profil',
              backgroundColor: kBlueColor,
            ),
          ],
        ),
      ),
    );
  }
}
