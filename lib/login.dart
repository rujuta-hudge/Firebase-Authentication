// @dart=2.9
import 'package:authentication_demo/Authentication_services.dart';
import 'package:authentication_demo/homescreen.dart';
import 'package:authentication_demo/register.dart';
import 'package:flutter/material.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({Key key}) : super(key: key);

  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text(
          "Login Page",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NewTegomin"),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),

                    // ignore: deprecated_member_use
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              fillColor: Colors.grey[300],
                              labelText: "E-Mail",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true),
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be Empty';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Invalid Format";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          maxLength: 8,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key),
                              fillColor: Colors.grey[300],
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true),
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be Empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            splashColor: Colors.white,
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.blue[800],
                            child: Text(
                              "Login",
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              String value;
                              if (_formKey.currentState.validate()) {
                                signInUser();
                              }
                            },
                          ),
                        ),

                        const SizedBox(width: 30.0),
                        // ignore: deprecated_member_use
                        FlatButton(
                          child: Text(
                            'Not registerd? Sign up',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    dynamic authResult =
        await _auth.loginUser(emailController.text, passwordController.text);
    if (authResult == null) {
      print("Login Error, Could not Sign In!");
    } else {
      emailController.clear();
      passwordController.clear();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      print("Sign In Successful!");
    }
  }
}
