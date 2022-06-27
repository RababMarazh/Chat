import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sajjad/pages/register_page.dart';
import '../helper/show_snackbar.dart';
import '../widgets/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset('images/register.png'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_TextFormtField(
                  PrefixIcon: Icons.email,
                 
                  onChange: (data) {
                    email = data;
                  },
                  validator: (data) {
                    if (data.isEmpty) {
                      return 'the data must not be empty';
                    }
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_TextFormtField(
                  PrefixIcon: Icons.password_rounded,
                   ObscureText: true,
                  onChange: (data) {
                    password = data;
                  },
                  validator: (data) {
                    if (data.isEmpty) {
                      return 'the data must not be empty';
                    }
                  },
                  hintText: 'password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBotton(
                  text: 'login',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        
                         Navigator.pushNamed(
                           context, 
                           Chat_Page.idhome,
                           arguments: email
                           );
                       
                    
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                           showSnackBar(context, 'user not found');
                        } else if (e.code == 'wrong-password') {
                           showSnackBar(context, 'wrong password');
                        }
                      }
                      isLoading = false;
                      setState(() {});
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
                        Navigator.pushNamed(context,Register_Page.id);
                      },
                      child: Text(
                        'Register',
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

  Future<UserCredential> loginUser() {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
