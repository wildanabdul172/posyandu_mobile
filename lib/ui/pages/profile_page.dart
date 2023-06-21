import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences _prefs;
  String? name, email, phoneNumber;
  bool _showLogoutConfirmation = false;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    _getUserData();
  }

  void _getUserData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('name');
      email = _prefs.getString('email');
      phoneNumber = _prefs.getString('phone_number');
    });
  }

  void _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _logout() {
    _prefs.remove('userId');
    _prefs.remove('name');
    _prefs.remove('email');
    _prefs.setBool('isLoggedIn', false);
    Get.offAllNamed('/');
  }

  void _confirmLogout() {
    _logout();
    setState(() {
      _showLogoutConfirmation = false;
    });
  }

  void _cancelLogout() {
    setState(() {
      _showLogoutConfirmation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      body: CustomScrollView(
        slivers: [
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
            title: Text(
              "Profil",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kBlueColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              name != null && name!.isNotEmpty
                                  ? name![0].toUpperCase()
                                  : "",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Warna teks huruf
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              email.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            Text(
                              phoneNumber.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Akun",
                      style: blackTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.all(
                          6,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: kBlackColor.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.child_care_rounded,
                              color: kBlueColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                "Tambah data anak",
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: kBlackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showLogoutConfirmation = true;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        padding: const EdgeInsets.all(
                          6,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: kBlackColor.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: kBlueColor,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                "Keluar",
                                style: blackTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: kBlackColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showLogoutConfirmation
          ? AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text('Konfirmasi Keluar'),
              content: const Text('Apakah Anda yakin ingin keluar?'),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: _cancelLogout,
                ),
                ElevatedButton(
                  child: const Text('Keluar'),
                  onPressed: _confirmLogout,
                ),
              ],
            )
          : null,
    );
  }
}
