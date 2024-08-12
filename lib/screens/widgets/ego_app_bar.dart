import 'package:doctor_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EgoAppBar extends StatelessWidget {
  const EgoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .40,
      width: size.width,
      decoration: const BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 16,
                  ),
                )),
            const SizedBox(height: 12),
            const Text(
              'Welcome back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Lets find',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'your top doctor!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search health issue',
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(color: Color(0xffbbc3d9)),
                prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                prefixIconColor: const Color(0xffbbc3d9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  // borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
