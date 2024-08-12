import 'package:doctor_app/clinics/presentation/clinic_bloc.dart';
import 'package:doctor_app/clinics/presentation/widget/clinics_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (BuildContext context) {
            return ClinicBloc();
          },
          child: const ClinicsView(),
        )

        // body: CustomScrollView(
        //   slivers: <Widget>[
        //     SliverAppBar(
        //       backgroundColor: Colors.transparent,
        //       // pinned: true,
        //       expandedHeight: 320.0,
        //       // stretch: true,
        //       flexibleSpace: FlexibleSpaceBar(
        //           // title: Text(
        //           //   'XDocs',
        //           //   style: TextStyle(
        //           //       color: Colors.white, fontWeight: FontWeight.bold),
        //           // ),
        //           background: Container(
        //         padding: EdgeInsets.all(24),
        //         // width: double.maxFinite,
        //         decoration: const BoxDecoration(
        //           color: primary,
        //           borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.circular(40),
        //             bottomRight: Radius.circular(40),
        //           ),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             const Align(
        //                 alignment: AlignmentDirectional.centerEnd,
        //                 child: SizedBox(
        //                   width: 60,
        //                   height: 60,
        //                   child: CircleAvatar(
        //                     backgroundColor: Colors.blue,
        //                     radius: 16,
        //                   ),
        //                 )),
        //             const SizedBox(height: 12),
        //             const Text(
        //               'Welcome back',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //             const Text(
        //               'Lets find',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 32,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             const Text(
        //               'your top doctor!',
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 32,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             const SizedBox(height: 24),
        //             // TextField(
        //             //   decoration: InputDecoration(
        //             //     hintText: 'Search health issue',
        //             //     filled: true,
        //             //     fillColor: Colors.white,
        //             //     hintStyle: const TextStyle(color: Color(0xffbbc3d9)),
        //             //     prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
        //             //     prefixIconColor: const Color(0xffbbc3d9),
        //             //     border: OutlineInputBorder(
        //             //       borderRadius: BorderRadius.circular(20),
        //             //       // borderSide: BorderSide(color: Colors.grey),
        //             //     ),
        //             //     enabledBorder: null,
        //             //   ),
        //             // ),
        //             const Row(
        //               children: [
        //                 Expanded(child: CustomTextBox()),
        //                 SizedBox(
        //                   width: 5,
        //                 ),
        //                 Icon(
        //                   Icons.filter_list_rounded,
        //                   color: primary,
        //                   size: 35,
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       )),
        //     ),
        //     // SliverGrid(
        //     //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //     //     maxCrossAxisExtent: 200.0,
        //     //     mainAxisSpacing: 10.0,
        //     //     crossAxisSpacing: 10.0,
        //     //     childAspectRatio: 4.0,
        //     //   ),
        //     //   delegate: SliverChildBuilderDelegate(
        //     //     (BuildContext context, int index) {
        //     //       return Container(
        //     //         alignment: Alignment.center,
        //     //         color: Colors.teal[100 * (index % 9)],
        //     //         child: Text('Grid Item $index'),
        //     //       );
        //     //     },
        //     //     childCount: 20,
        //     //   ),
        //     // ),
        //
        //
        //     // SliverFixedExtentList(
        //     //   itemExtent: 120.0,
        //     //   delegate: SliverChildBuilderDelegate(
        //     //     childCount: 12,
        //     //     (BuildContext context, int index) {
        //     //       return const DoctorCard(
        //     //           doctorName: 'doctorName',
        //     //           specialization: 'specialization',
        //     //           imageUrl: 'imageUrl');
        //     //     },
        //     //   ),
        //     // ),
        //   ],
        // ),
        // bottomNavigationBar:
        //     CustomNavigationBar(currentIndex: 1, onTabTapped: (i) {}),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   shape: CircleBorder(),
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        );
  }
}

class CustomNavigationBar extends BottomAppBar {
  final int currentIndex;
  final Function(int) onTabTapped;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          left: 12,
          right: 12,
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.3),
              //     spreadRadius: 3,
              //     blurRadius: 7,
              //     offset: Offset(0, 3),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 0),
                _buildNavItem(Icons.calendar_today, 1),
                // SizedBox(width: 40), // The gap for the floating button
                // _buildNavItem(Icons.person, 2),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 60, // Adjust as needed
          left: MediaQuery.of(context).size.width / 2 - 30, // Adjust as needed
          child: FloatingActionButton(
            onPressed: () {
              // Add button pressed
            },
            backgroundColor: Colors.purple,
            elevation: 2,
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: index == currentIndex ? Colors.purple : Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
