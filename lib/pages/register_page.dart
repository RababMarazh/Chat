import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'chat_page.dart';

class Register_Page extends StatefulWidget {
  Register_Page({Key? key}) : super(key: key);
  static String id ='Register_Page';

  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  String? email;

  String? password;

  bool isLoadind=false;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoadind ,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key:formKey ,
            child: ListView(
              children: [
                Image.asset('images/register.png'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Custom_TextFormtField(
                  validator: (data){
                    if (data.isEmpty) {return'the data must not be empty';
                      
                    }
                  },
                    hintText: 'Email',
                    onChange: (data) {
                      email = data;
                      
                    }),
                const SizedBox(
                  height: 20,
                ),
                Custom_TextFormtField(
                  validator: (data){
                    if (data.isEmpty) {return'the password is weak';
                      
                    }},
                  hintText: 'password',
                  onChange: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBotton(
                  text: 'register',
                  ontap: () async {if (formKey.currentState!.validate()) {
                    
                  isLoadind=true;
                  setState(() {
                    
                  });
                    try {
                      await 
                      registerUser();
                       Navigator.pushNamed(context, Chat_Page.idhome,arguments: email);




                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context, 'weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'email already in use');
                      }
                    }
                    isLoadind=false;
                    setState(() {
                      
                    });
                    
                  }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'login',
                         style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 18),
                      
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<UserCredential> registerUser() {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
