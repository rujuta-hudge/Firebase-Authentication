import 'package:authentication_demo/login.dart';
import 'package:flutter/material.dart';
import 'package:authentication_demo/Authentication_services.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Home page!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                onPressed: () async {
                  await _auth.signOut().then((result) {
                    Navigator.of(context).pop(true);
                  });
                },
                child: Text(
                  "SignOut",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
