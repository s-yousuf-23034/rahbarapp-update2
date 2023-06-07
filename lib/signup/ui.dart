import 'package:rahbarapp/Course/CourseList.dart';
import 'package:rahbarapp/login/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/signup/bloc/SignUpBloc.dart';
import 'package:rahbarapp/signup/bloc/SignUpState.dart';
import 'package:rahbarapp/widgets/textformfield.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp regExp = RegExp(SignUp.pattern as String);

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final adminStatusOptions = ['Non-Admin', 'Admin'];
  String selectedAdminStatus = 'Non-Admin'; // Default admin status

  String? validation() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Name cannot be Empty',
        ),
      ));
    } else if (nameController.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check Your Name'),
        ),
      );
    }

    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Email cannot be Empty',
        ),
      ));
    } else if (!regExp.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please enter the valid Email',
        ),
      ));
    }
    if (passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Password cannot be Empty',
        ),
      ));
    } else if (passwordController.text.trim().length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password length must be at least 8.'),
        ),
      );
    } else if (SignUpState is SignUpFailure) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      registerUser();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Registered Successfully',
        ),
      ));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CourseList(
      //       username: nameController.text,
      //       isAdmin: selectedAdminStatus == 'Admin',
      //     ),
      //   ),
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpBloc(),
        child: Scaffold(
            backgroundColor: Colors.amber,
            // body: BlocConsumer<SignUpBloc, SignUpState>(
            //   listener: (context, state) {
            //     if (state is SignUpSuccess) {

            //     } else if (state is SignUpFailure) {
            //       showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //           title: Text('Sign Up Error'),
            //           content: Text(state.error),
            //           actions: [
            //             TextButton(
            //               onPressed: () => Navigator.pop(context),
            //               child: Text('OK'),
            //             ),
            //           ],
            //         ),
            //       );
            //     }
            //   },
            // builder: (context, state) {
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Image.asset(
                    "assets/images/welcome.png",
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 32.0,
                          ),
                          child: Column(
                            children: [
                              MyTextField(
                                value: false,
                                hinttext: 'Name',
                                labeltext: 'Name',
                                color: Color.fromARGB(255, 60, 5, 69),
                                type: TextInputType.text,
                                action: TextInputAction.next,
                                controller: nameController,
                              ),
                              MyTextField(
                                value: false,
                                hinttext: 'abc@gmail.com',
                                labeltext: 'Email',
                                color: Color.fromARGB(255, 60, 5, 69),
                                type: TextInputType.emailAddress,
                                action: TextInputAction.next,
                                controller: emailController,
                              ),
                              MyTextField(
                                value: true,
                                hinttext: 'Enter Password',
                                labeltext: 'Password',
                                color: Color.fromARGB(255, 60, 5, 69),
                                type: TextInputType.text,
                                action: TextInputAction.done,
                                controller: passwordController,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  validation();
                                  // try {
                                  //   UserCredential userCredential =
                                  //       await _auth
                                  //           .createUserWithEmailAndPassword(
                                  //     email: emailController.text.toString(),
                                  //     password:
                                  //         passwordController.text.toString(),
                                  //   );
                                  //   User? user = userCredential.user;
                                  //   if (user != null) {
                                  //     await FirebaseFirestore.instance
                                  //         .collection('users')
                                  //         .doc(user.uid)
                                  //         .set({
                                  //       'name': nameController.text,
                                  //       'email': emailController.text,
                                  //       'password': passwordController.text,
                                  //       'adminStatus': selectedAdminStatus,
                                  //     });
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => CourseList(
                                  //           username: nameController.text,
                                  //           isAdmin: selectedAdminStatus ==
                                  //               'Admin',
                                  //         ),
                                  //       ),
                                  //     );
                                  //   }
                                  // } catch (e) {
                                  //   print(e);
                                  // }
                                },
                                child: Text('SignUp'),
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  minimumSize: Size(350, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 60, 5, 69),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1.0,
                                      color: Color.fromARGB(255, 60, 5, 69),
                                    ),
                                  ),
                                  Text(
                                    " OR CONNECT WITH ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 60, 5, 69),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1.0,
                                      color: Color.fromARGB(255, 60, 5, 69),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle Google sign-in
                                },
                                icon: Icon(Icons.g_mobiledata),
                                label: Text('Sign in with Google'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Future<void> registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'adminStatus': selectedAdminStatus,
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CourseList(
        //       username: nameController.text,
        //       isAdmin: selectedAdminStatus == 'Admin',
        //     ),
        //   ),
        // );
      }
    } catch (e) {
      print(e);
    }
  }
}
