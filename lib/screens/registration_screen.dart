import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/buttons.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Buttons(
                colour: Colors.blueAccent,
                onpress: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      _isLoading = false;
                    });

                    Alert(
                      context: context,
                      title: "Sign up successfully",
                      desc: "Chat nicely !",
                      style: AlertStyle(
                        backgroundColor: Colors.white,
                        animationType: AnimationType.grow,
                      ),
                    ).show();
                  } catch (e) {
                    print(e);
                  }
                },
                text: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
