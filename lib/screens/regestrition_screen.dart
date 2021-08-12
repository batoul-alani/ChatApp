//import 'dart:html';
import 'package:flat_chat/components/round_button.dart';
import 'package:flat_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id='Registrition_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin{
  final _auth=FirebaseAuth.instance;
  String email;
  String password;

  AnimationController controller;
  Animation animation;

  bool showSpanner =false;
  
  @override
  void initState() {
    controller=AnimationController(
      duration: Duration(seconds: 1),
        vsync: this,
    );
    animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpanner,
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
                    height: animation.value*100,
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
                  email=value;
                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter your Email',),
              ),

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
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter Your Password',)
              ),

              SizedBox(
                height: 24.0,
              ),

              RoundButton(
                colour: Colors.blueAccent,
                onPressed: ()async{
                  setState(() {
                    showSpanner=true;
                  });
                  try {
                    print(email);
                    print(password);
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser !=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpanner=false;
                    });
                  }
                  catch(e){
                    print(e);
                  }
                },
                buttonText: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
