import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/doctors/presentation/pages/doctor_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/common/widgets/widgets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/functions/helpers.dart';
import '../tabs/ScheduleTab.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aboutController = TextEditingController();
  List<int> _workingDays = [];
  String? _selectedClinic;
  bool _isLoading = false;
  final _keyForm = GlobalKey<FormState>();
  bool isChangeSuffixIcon = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final userBloc = BlocProvider.of<UserBloc>(context);
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    // return BlocListener<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if( state is LoadingAuthState ){
    //       modalLoading(context, 'Checking...');
    //     }else if( state is FailureAuthState ){
    //       Navigator.pop(context);
    //       errorMessageSnack(context, state.error);
    //     }else if( state is SuccessAuthState ){
    //       Navigator.pop(context);
    //       userBloc.add(OnGetUserEvent());
    //       Navigator.pushAndRemoveUntil(context, routeSlide(page: HomePage()), (_) => false);
    //     }
    //   },
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: IconButton(
      //     splashRadius: 20,
      //     icon: const Icon(Icons.close_rounded, size: 25, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   actions: [
      //     TextButton(
      //       child: EgoText(
      //         text: 'Register',
      //         fontSize: 18,
      //         color: EgoColors.primaryColor,
      //       ),
      //       onPressed: () =>
      //           Navigator.of(context).pushReplacementNamed('signUpPage'),
      //     )
      //   ],
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: SafeArea(
          child: Stack(
        children: [
          // Container(
          //   width: 635,
          //   height: 635,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(320), color: Colors.green),
          // ),
          Positioned(
              top: -171,
              left: 23,
              // right: 23,
              child: Container(
                width: 496,
                height: 496,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(320),
                  border: Border.all(
                      color: const Color(0xffF8F9FF),
                      style: BorderStyle.solid,
                      width: 4),
                  color: Colors.white,
                ),
              )),
          Positioned(
              top: -356,
              // left: 0,
              right: -356,
              child: Container(
                width: 635,
                height: 635,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(320),
                    color: const Color(
                      0xffF8F9FF,
                    )),
              )),
          Positioned(
            bottom: -306,
            // left: 0,
            left: -356,
            child: Container(
              width: 496,
              height: 496,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(320),
                border: Border.all(
                    color: const Color(0xffF8F9FF),
                    style: BorderStyle.solid,
                    width: 4),
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 97),
            child: Form(
              key: _keyForm,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: EgoText(
                      text: 'New Doctor?',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      // color: Color(0xff1F41BB),
                      color: EgoColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Center(
                      child: SizedBox(
                    height: 62,
                    width: 326,
                    child: Column(
                      children: [
                        EgoText(
                          text: 'Create an account so you can help',
                          // maxLines: ,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                        ),
                        EgoText(
                          text: ' Who in a need',
                          maxLines: 2,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 74),

                  EgoTextForm(
                    controller: _nameController,
                    // keyboardType: TextInputType.emailAddress,

                    validator: requiredValidator,
                    hintText: 'Doctor name',
                    prefixIcon: const Icon(Icons.person_2_rounded),
                  ),
                  const SizedBox(height: 20),
                  EgoTextForm(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: requiredValidator.call,
                    hintText: 'Phone number',
                    prefixIcon: const Icon(Icons.phone_rounded),
                  ),
                  const SizedBox(height: 20),
                  EgoTextForm(
                    controller: _specializationController,
                    // keyboardType: TextInputType.d,

                    validator: requiredValidator.call,
                    hintText: 'Specialization',
                    prefixIcon: const Icon(Icons.local_hospital_rounded),
                  ),
                  const SizedBox(height: 20),
                  EgoTextForm(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: validatedEmail.call,
                    hintText: 'Email ID',
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                  ),
                  const SizedBox(height: 20),
                  EgoTextForm(
                    controller: _passwordController,
                    isPassword: isChangeSuffixIcon,
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password_rounded),
                    validator: passwordValidator.call,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: requiredValidator.call,
                    controller: _aboutController,
                    style: GoogleFonts.getFont('Roboto', fontSize: 17),
                    cursorColor: const Color(0xff1F41BB),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 6,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15.0),
                      filled: true,
                      fillColor: const Color(0xffF1F4FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xff1F41BB),
                          // color: EgoColors.primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          // color: Color(0xff1F41BB),
                          color: EgoColors.primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          // color: Color(0xff1F41BB),
                          color: EgoColors.primaryColor,
                        ),
                      ),
                      hintText: 'About Yourself',
                      // prefixIcon: Icon(Icons.description_rounded),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('clinics')
                        .snapshots(),
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
                        decoration:
                            const InputDecoration(labelText: "Select Clinic"),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  EgoText(
                    text: 'Select your working days:',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  WeekDays(
                    doctorWorkingDays: [],
                    onSelectedDaysChanged: (List<int> value) {
                      _workingDays = value;
                      print(_workingDays);
                    },
                  ),
                  const SizedBox(height: 80),
                  EgoButton(
                      text: 'Sign up',
                      width: size.width,
                      // backgroundColor: Color(0xff1F41BB),
                      backgroundColor: EgoColors.primaryColor,
                      fontSize: 18,
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          _registerDoctor();
                          Navigator.of(context).push(
                            routeSlide(page: const ScheduleTab()),
                          );
                        }
                      }
                      // if (_keyForm.currentState!.validate()) {
                      //   authBloc.add(LoginEvent(_emailController.text.trim(),
                      //       _passowrdController.text.trim()));
                      // }
                      ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const EgoText(
                        text: 'Already have an account',
                        color: Color(0xff494949),
                        fontSize: 14,
                        isTitle: true,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            routeSlide(page: const LoginScreen()),
                            (_) => false);
                      },
                    ),
                    // onPressed: () => Navigator.push(
                    //     context, routeSlide(page: HomeScreen()))),
                  ),
                  const SizedBox(height: 30),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: TextButton(
                  //     child: EgoText(
                  //       text: 'Or continue with',
                  //       color: Color(0xff1F41BB),
                  //       fontSize: 14,
                  //       isTitle: true,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  //   // onPressed: () => Navigator.push(
                  //   //     context, routeSlide(page: HomeScreen()))),
                  // ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _registerDoctor() async {
    if (_selectedClinic == null) {
      errorMessageSnack(context, 'Please select a clinic');

      return;
    }
    if (_workingDays.isEmpty) {
      errorMessageSnack(context, 'please select working days');
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
        'about': _aboutController.text,
        'workingDays': _workingDays,
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
