import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ super.key });

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Account")),
    );
  }
}