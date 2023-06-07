import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/home/bloc/splash_bloc.dart';
import 'package:rahbarapp/home/bloc/splash_state.dart';
import 'package:rahbarapp/login/Login.dart';
import 'package:rahbarapp/signup/ui.dart';

class Home extends StatelessWidget {
  // final FirebaseAuth auth;

  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SplashBloc splashBloc = BlocProvider.of<SplashBloc>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 182, 2, 3),
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashScreenNavigateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(90.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                          color: Color.fromRGBO(85, 24, 93, 9),
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'RAHBAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      "assets/images/welcome.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Let',
                      style: TextStyle(
                        color: Color.fromRGBO(85, 24, 93, 9),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'RAHBAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Steer you to Success',
                      style: TextStyle(
                        color: Color.fromRGBO(85, 24, 93, 9),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
