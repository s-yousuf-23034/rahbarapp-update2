import 'package:email_validator/email_validator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rahbarapp/Admin/AdminSettingPage.dart';
import 'package:rahbarapp/Course/CourseList.dart';
import 'package:rahbarapp/login/bloc/LoginBloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/signup/ui.dart';
import 'package:rahbarapp/widgets/textformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool? isAdmin;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<String> fetchUserName(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String userName = userData['name'];
      return userName;
    } else {
      return '';
    }
  }

  void navigateToAdminSettingsPage(String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminSettingsPage(
          userName: userName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/welcome.png",
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(height: 20),
                  MyTextField(
                    hinttext: " abc@gmail.com",
                    labeltext: "Email",
                    color: Color.fromARGB(255, 60, 5, 69),
                    type: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    controller: emailController,
                    value: false,
                  ),
                  const SizedBox(height: 20.0),
                  MyTextField(
                    hinttext: "Password",
                    labeltext: "Password",
                    color: Color.fromARGB(255, 60, 5, 69),
                    type: TextInputType.text,
                    action: TextInputAction.next,
                    controller: passwordController,
                    value: true,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 60, 5, 69),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        );

                        if (userCredential.user != null) {
                          String userName =
                              await fetchUserName(userCredential.user!.uid);

                          isAdmin = await _loginBloc.isAdmin(
                            emailController.text.toString(),
                            passwordController.text.toString(),
                          );

                          bool isAdminValue = isAdmin ?? false;

                          if (isAdminValue) {
                            navigateToAdminSettingsPage(userName);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseList(
                                  username: userName,
                                  isAdmin: isAdminValue,
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      minimumSize: Size(350, 50),
                      backgroundColor: Color.fromARGB(255, 60, 5, 69),
                    ),
                  ),
                  const SizedBox(height: 10.0),
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
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Add Google sign-in functionality here
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 2,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "  Google",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 60, 5, 69),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
