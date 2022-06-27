import 'package:flutter/material.dart';

import 'constants.dart';

class CustomBotton extends StatelessWidget {
   CustomBotton({ this.ontap,required this.text}) ;
 String text;
 VoidCallback?ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:ontap ,
      child: Container(
                 width: double.infinity,
                 height: 50,
                 decoration: BoxDecoration(
                   color: kbuttomColor,
                   borderRadius: BorderRadius.circular(8),
                    
                   
                 ),
                 child: Center(child:
                  Text(text,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),)),
               ),
    );
  }
}