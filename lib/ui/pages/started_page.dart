import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu/shared/theme.dart';
import 'package:posyandu/ui/widget/custom_button_auth.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 40,
          ),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonAuth(
                      title: "Mulai",
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
