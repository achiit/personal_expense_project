import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import '../../widgets/custom_appbar.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? currentText;
  late Timer _timer;
  int _start = 60;
  bool isLoading = false;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isLoading = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar('Verification'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 195,
              ),
              Text(
                "Enter your Verification Code",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 32),
              ),
              SizedBox(
                height: 50,
              ),
              otp_field(context),
              SizedBox(
                height: 30,
              ),
              //const SizedBox(height: 30),
              _start != 0
                  ? Row(
                      children: [
                        /* Text(
                          "Resend Code in",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ), */
                        const SizedBox(width: 10),
                        Text(
                          _start.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Don't receive code?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _start = 60;
                              isLoading = true;
                              startTimer();
                            });
                          },
                          child: Text(
                            "Request again",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Padding otp_field(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PinCodeTextField(
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          selectedColor: Colors.grey,
          inactiveColor: Colors.grey,
          activeColor: Color(0XFF7F3DFF),
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          //activeFillColor: Colors.grey,
        ),
        animationDuration: Duration(milliseconds: 300),
        //backgroundColor: Colors.grey,
        //enableActiveFill: true,
        //errorAnimationController: errorController,
        //controller: textEditingController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
          setState(() {
            currentText = value;
          });
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: context,
      ),
    );
  }
}
