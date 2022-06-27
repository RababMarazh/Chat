
import 'package:flutter/material.dart';
import 'package:sajjad/pages/chat_page.dart';
import 'package:sajjad/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sajjad/pages/register_page.dart';


void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       routes:{
          'LoginPage':(context)=>LoginPage(),
          Register_Page.id:(context)=>Register_Page(),
          Chat_Page.idhome:(context)=>Chat_Page(),
          },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'LoginPage', 
      );
 }
}


