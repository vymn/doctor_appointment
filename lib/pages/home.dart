import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'doctor_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _pages = [
    // const HomePage(),
    const HomeScreen(),
    const DoctorPage(),
    // const ChatPage(),
    Container(),
    Container(),
    // Container()
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: _pages),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: primary,
              inactiveColor: Colors.black,
              title: const Text('Home'),
              icon: const Icon(FontAwesomeIcons.house)),
          BottomNavyBarItem(
              activeColor: primary,
              inactiveColor: Colors.black,
              title: const Text('Doctor'),
              icon: const Icon(FontAwesomeIcons.userDoctor)),
          // BottomNavyBarItem(
          //     activeColor: primary,
          //     inactiveColor: Colors.black,
          //     title: const Text('Chat'),
          //     icon: const Icon(FontAwesomeIcons.message)),
          BottomNavyBarItem(
              activeColor: primary,
              inactiveColor: Colors.black,
              title: const Text('Booking'),
              icon: const Icon(FontAwesomeIcons.calendar)),
          // BottomNavyBarItem(
          //     activeColor: primary,
          //     inactiveColor: Colors.black,
          //     title: const Text('Account'),
          //     icon: const Icon(Icons.manage_accounts_rounded)),
        ],
      ),
    );
  }
}

class EgoBottomNavBar extends StatelessWidget {
  const EgoBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
