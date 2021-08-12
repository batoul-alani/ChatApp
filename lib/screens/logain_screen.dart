import 'package:flutter/material.dart';
import 'package:flat_chat/components/round_button.dart';
import 'package:flat_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcom_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _auth=FirebaseAuth.instance;
  String email='';
  String password='';

  bool showSpannerinloginScreen=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpannerinloginScreen,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),

              SizedBox(
                height: 48.0,
              ),

              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email= value;
                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
              ), //Email field

              SizedBox(
                height: 8.0,
              ),

              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
              ), //password field

              SizedBox(
                height: 24.0,
              ),

              RoundButton(
                colour: Colors.lightBlueAccent,
                onPressed: () async{
                  setState(() {
                    showSpannerinloginScreen=true;
                  });
                  try{
                    final user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
                    if (user !=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpannerinloginScreen=false;
                    });
                  }
                  catch(e){
                    Navigator.pushNamed(context, WelcomeScreen.id);
                    print(e);
                   }//Implement login functionality.
                },
                buttonText: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}