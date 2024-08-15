import 'package:flutter/material.dart';

class EgoAppBar extends StatelessWidget {
  const EgoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مستشفي',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'مكه للعيون',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        // CircleAvatar(
        //   backgroundImage: AssetImage('assets/person.jpeg'),
        // )
      ],
    );
  }
}
