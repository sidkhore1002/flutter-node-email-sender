import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  var emailID = "";
  bool valid_email = false;
  int OTP = 123456;

  @override
  void initState() {}

// -----------

  Future<void> sendEmail(emailID, context) async {
    print(emailID);

    var email_API_Url =
        "https://nodejs-flutter-vercel-deployment.vercel.app/sendemail";

    var emailResponse = await http.post(Uri.parse(email_API_Url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"emailId": emailID}));
    print(emailResponse);

  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Color(0xff1879C0),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Center(
                child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.99),
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          height: mediaQuery.size.height * 0.6,
          width: mediaQuery.size.width * 0.55,
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(
                  bottom: mediaQuery.size.height * 0.08,
                  top: mediaQuery.size.height * 0.05),
              child: Text(
                "Enter Your Email",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery.size.width * 0.03,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: mediaQuery.size.width * 0.3,
              height: mediaQuery.size.height * 0.07,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.grey,
                  ),
                ],
              ),
              child: TextField(
                textAlign: TextAlign.center,
                maxLines: 1,
                onChanged: (text) {
                  emailID = text;
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailID);
                  if (emailValid == true) {
                    setState(() {
                      valid_email = true;
                      emailID = text;
                    });
                  } else {
                    setState(() {
                      valid_email = false;
                    });
                  }
                },
                style: TextStyle(
                    fontSize: mediaQuery.size.width * 0.015,
                    color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'ENTER  EMAIL',
                  hintStyle: TextStyle(fontSize: mediaQuery.size.width * 0.015),
                  counterText: '',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 0, top: 0),
                ),
              ),
            ),
            SizedBox(
              width: mediaQuery.size.width * 0.03,
              height: mediaQuery.size.height * 0.07,
            ),
            Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: mediaQuery.size.width * 0.05,
                  ),
                  padding: EdgeInsets.only(right: mediaQuery.size.width * 0.02),
                  onPressed: () async {
                    if (valid_email == true) {
                      // FocusScope.of(context).unfocus();
                      sendEmail(emailID, context);
                    } else {
                      final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text('Please enter valid EmailID'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                )),
          ]),
        ))));
  }
}
