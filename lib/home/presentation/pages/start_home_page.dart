import 'package:doctor_app/auth/sign_up_screen.dart';
import 'package:doctor_app/core/constants/colors.dart';
import 'package:doctor_app/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../auth/login_screen.dart';
import '../../../core/common/widgets/widgets.dart';
import '../../../core/functions/helpers.dart';

class StartHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: EgoColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CircleAvatar(
                      //   radius: 70,
                      //   child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(120),
                      //       child: Image.asset('assets/fraved_logo.png')),
                      // ),
                      SizedBox(height: 15.0),
                      EgoText(
                          text: 'مستشفي مكه للعيون',
                          isTitle: true,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      EgoText(
                          text: 'نحن نهتم بالطريقه التي تري بها العالم!',
                          fontSize: 16,
                          isTitle: true,
                          color: Colors.white70),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      EgoButton(
                          text: 'هل انت طبيب؟',
                          isTitle: true,
                          height: 55,
                          fontSize: 18,
                          border: 60,
                          fontWeight: FontWeight.w600,
                          colorText: Colors.white,
                          backgroundColor: const Color(0xff1C2834),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen())),
                          width: size.width),
                      const SizedBox(height: 15.0),
                      EgoButton(
                        text: 'او احجز موعد مع طبيبك',
                        colorText: Colors.black87,
                        fontSize: 18,
                        border: 60,
                        isTitle: true,
                        fontWeight: FontWeight.w600,
                        backgroundColor: Color(0xFFE9EFF9),
                        width: size.width,
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen())),
                      ),
                      const SizedBox(height: 10.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const EgoText(
                      //       text: 'Don\'t have an account?',
                      //       fontSize: 17,
                      //       color: Colors.white70,
                      //     ),
                      //     TextButton(
                      //       child: const EgoText(
                      //           text: 'Sign up',
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //       onPressed: () => Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //               builder: (_) => const SignupScreen())),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
