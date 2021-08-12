import 'package:flat_chat/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'logain_screen.dart';
import 'regestrition_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flat_chat/components/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(duration:Duration(seconds: 1),vsync: this);
    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),

                TypewriterAnimatedTextKit(
                    text: ['Flash Chat'],
                    textStyle: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),),
                    //speed: const Duration(milliseconds: controlle),
                  //pause: const Duration(milliseconds: 1000),
                  ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              colour: Colors.lightBlue,
              onPressed: () {
             Navigator.pushNamed(context, LoginScreen.id);
             //Go to login screen.
           },
              buttonText: Text('Log in',
                style: TextStyle(
                  color: Colors.white,
                ),),
            ),
            RoundButton(
              colour: Colors.blueAccent,
              onPressed: () {
             Navigator.pushNamed(context, RegistrationScreen.id);
             //Go to login screen.
           },
              buttonText: Text('Registration',style: TextStyle(
                color: Colors.white,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
