import 'package:doctor_app/tabs/ScheduleTab.dart';
import 'package:doctor_app/vymn/patient_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'doctor_appointments.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DoctorScreen(),
    const PatientScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointment App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Patient',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null ? const DoctorLogin() : const DoctorAppointments();
  }
}

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScheduleTab()),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorSignUp()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  _DoctorSignUpState createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedClinic;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _specializationController,
              decoration: const InputDecoration(labelText: 'Specialization'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('clinics').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                List<DropdownMenuItem<String>> clinicItems = [];
                for (var doc in snapshot.data!.docs) {
                  clinicItems.add(
                    DropdownMenuItem(
                      value: doc.id,
                      child: Text(doc['name']),
                    ),
                  );
                }
                return DropdownButtonFormField<String>(
                  items: clinicItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedClinic = value;
                    });
                  },
                  value: _selectedClinic,
                  decoration: const InputDecoration(labelText: "Select Clinic"),
                );
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _registerDoctor,
                    child: const Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }

  void _registerDoctor() async {
    if (_selectedClinic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a clinic')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection('clinics')
          .doc(_selectedClinic)
          .collection('doctors')
          .doc(uid)
          .set({
        'name': _nameController.text,
        'specialization': _specializationController.text,
        'phoneNumber': _phoneController.text,
        'email': _emailController.text,
      });

      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _specializationController.clear();
      _phoneController.clear();
      setState(() {
        _selectedClinic = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Doctor registered successfully')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
