//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flat_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore=FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String id='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

User loggedInUser;
class _ChatScreenState extends State<ChatScreen> {
  final messageTextController=TextEditingController();
  final _auth=FirebaseAuth.instance;

  String messageText="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      User user= FirebaseAuth.instance.currentUser;
    if(user !=null){
      loggedInUser=user;
      print(loggedInUser);}
      }
    catch(e){
      print(e); }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                 _auth.signOut();
                 Navigator.pop(context);
                //Implement logout functionality
              }), ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText=value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      //final user= _auth.currentUser;
                      _fireStore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                      //Implement send functionality.
                    },

                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
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

class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot){

        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages=snapshot.data.docs.reversed;
        List<MessageBubble> messageWidgets=[];
        for(var message in messages){
          final messageText=message.get('text');
          final messageSender=message.get('sender');

          final currentUser= loggedInUser.email;

          final messageBubble= MessageBubble(text: messageText, sender: messageSender,isMe: currentUser==messageSender,);
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            children: messageWidgets, ),
        );

      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({this.text,this.sender,this.isMe});

  final bool isMe;
  MaterialAccentColor c;

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender, style: TextStyle(
            fontSize: 10.0,
            color: Colors.black45,
          ),),
        Material(
          borderRadius: isMe? BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)): BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
          elevation: 5.0,

          color: isMe ? Colors.lightBlueAccent: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),
            child: Text(
              text,
              style: TextStyle(
                color: isMe? Colors.white: Colors.black45,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
    ],
      ),
    );
  }
}
