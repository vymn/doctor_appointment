import 'package:doctor_app/core/constants/colors.dart';
import 'package:doctor_app/firebase_options.dart';
import 'package:doctor_app/home/presentation/pages/start_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, ch) => Directionality(
        textDirection: TextDirection.rtl,
        child: ch!,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: EgoColors.primaryColor,
        fontFamily: GoogleFonts.tajawal().fontFamily,
      ),
      home: StartHomePage(),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// List<Map> navigationBarItems = [
//   {'icon': Icons.local_hospital, 'index': 0},
//   {'icon': Icons.calendar_today, 'index': 1},
// ];
//
// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;
//   void goToSchedule() {
//     setState(() {
//       _selectedIndex = 1;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       HomeTab(
//         onPressedScheduleCard: goToSchedule,
//       ),
//       const ScheduleTab(),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(MyColors.primary),
//         elevation: 0,
//         title: const Text(
//           'مستشفي مكه للعيون',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: BlocProvider(
//           create: (BuildContext context) => ClinicBloc(),
//           child: screens[_selectedIndex],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedFontSize: 0,
//         selectedItemColor: Color(MyColors.primary),
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           for (var navigationBarItem in navigationBarItems)
//             BottomNavigationBarItem(
//               icon: Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: _selectedIndex == navigationBarItem['index']
//                         ? BorderSide(color: Color(MyColors.bg01), width: 5)
//                         : BorderSide.none,
//                   ),
//                 ),
//                 child: Icon(
//                   navigationBarItem['icon'],
//                   color: _selectedIndex == 0
//                       ? Color(MyColors.bg01)
//                       : Color(MyColors.bg02),
//                 ),
//               ),
//               label: '',
//             ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (value) => setState(() {
//           _selectedIndex = value;
//         }),
//       ),
//     );
//   }
// }
