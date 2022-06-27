import 'package:flutter/material.dart';
import 'package:sajjad/models/message.dart';

import 'constants.dart';

class ChatBuble_Friend extends StatelessWidget {
  const ChatBuble_Friend({
    required this.massage,
  }) ;
final Message massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container( 
       
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kbuttomColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),)
    
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(massage.message,
          style: TextStyle(color: Colors.white),),
        ),
        
      ),
    );
  }
}