import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_expense/screens/Screens/otp_screen.dart';

import '../../helper/textfield_stling.dart';
import '../../signupmethods/google_sginin.dart';
import '../../widgets/button_widgets.dart';
import '../../widgets/custom_appbar.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isSigningIn = false;
  bool? isChecked = false;

  String? _password;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: Appbar('Sign Up'),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 72,
                ),
                Form(
                    child: Column(
                  children: [
                    Container(
                      height: 66,
                      width: 380,
                      child: TextField(
                        decoration: ThemeHelper().textInputDecoration(
                            'Name', 'Enter your user name'),
                        style: TextStyle(fontSize: 17),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      height: 66,
                      width: 380,
                      child: TextField(
                        decoration:
                            ThemeHelper().textInputDecoration('Email', ''),
                        style: TextStyle(fontSize: 17),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      height: 66,
                      width: 380,
                      child: TextField(
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'Password', 'Enter your password'),
                        style: TextStyle(fontSize: 17),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 17.0),
                    CheckboxListTile(
                      selectedTileColor: Color(0XFF7F3DFF),
                      title: const Text.rich(
                        TextSpan(
                          text: '',
                          style: TextStyle(fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'By signing up, you agree to the ',
                            ),
                            TextSpan(
                                text: 'Terms of Service and Privacy Policy',
                                style: TextStyle(color: Color(0XFF7F3DFF)))
                          ],
                        ),
                      ),
                      value: isChecked,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      //secondary: const Icon(Icons.hourglass_empty),
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Column(children: [
                      Container(
                        width: 343,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(OtpScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF7F3DFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                          ),
                          child: Text(
                            "SignUp",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or with",
                          style: TextStyle(
                            color: Color(0XFF91919F),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Column(children: [
                      Container(
                        width: 343,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isSigningIn = true;
                            });

                            User? user = await Authentication.signInWithGoogle(
                                context: context);

                            setState(() {
                              _isSigningIn = false;
                            });

                            if (user != null) {
                              print("hello");
                              Get.to(OtpScreen());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 195, 195, 196))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google icon.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign Up with Google",
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.inter(
                                  color: Color(0XFF91919F),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: 'Login',
                              /* recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  /* Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())) */;
                                }, */
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF7F3DFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
