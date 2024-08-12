import 'package:doctor_app/auth/login_screen.dart';
import 'package:doctor_app/doctors/presentation/bloc/doctors_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../clinics/presentation/clinic_bloc.dart';
import '../../../core/styles/colors.dart';
import 'HomeTab.dart';
import '../../../tabs/ScheduleTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.local_hospital, 'index': 0},
  {'icon': Icons.calendar_today, 'index': 1},
];

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    List<Widget> screens = [
      HomeTab(
        onPressedScheduleCard: user != null
            ? goToSchedule
            : () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LoginScreen())),
      ),
      (user != null) ? const ScheduleTab() : const LoginScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Color(MyColors.primary),
      //   elevation: 0,
      //   title: const Text(
      //     'مستشفي مكه للعيون',
      //     style: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
          child: MultiBlocProvider(
        providers: [
          BlocProvider<ClinicBloc>(create: (_) => ClinicBloc()),
          BlocProvider<DoctorsBloc>(create: (_) => DoctorsBloc()),
        ],
        child: screens[_selectedIndex],
      )),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedFontSize: 0,
      //   selectedItemColor: Color(MyColors.primary),
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   items: [
      //     for (var navigationBarItem in navigationBarItems)
      //       BottomNavigationBarItem(
      //         icon: Container(
      //           height: 55,
      //           decoration: BoxDecoration(
      //             border: Border(
      //               top: _selectedIndex == navigationBarItem['index']
      //                   ? BorderSide(color: Color(MyColors.bg01), width: 5)
      //                   : BorderSide.none,
      //             ),
      //           ),
      //           child: Icon(
      //             navigationBarItem['icon'],
      //             color: _selectedIndex == 0
      //                 ? Color(MyColors.bg01)
      //                 : Color(MyColors.bg02),
      //           ),
      //         ),
      //         label: '',
      //       ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: (value) => setState(() {
      //     _selectedIndex = value;
      //   }),
      // ),
    );
  }
}
