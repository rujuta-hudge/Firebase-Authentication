// @dart=2.9
import 'package:authentication_demo/Authentication_services.dart';
import 'package:authentication_demo/login.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade400,
        title: Text(
          "Registeration",
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
                    "SIGN UP",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NewTegomin"),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 50),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    height: 430,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    // ignore: deprecated_member_use
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              fillColor: Colors.grey[300],
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true),
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
                              return "Invalid Format";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
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
                              return 'Please enter some text';
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
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          //validator: validatepass
                          //MinLengthValidator(6, errorText: "Should be atleast 6 characters!"),  for custom validation
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              String value;
                              if (_formKey.currentState.validate()) {
                                createUser();
                              }
                            },
                            splashColor: Colors.blue[800],
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blue.shade600),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
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

  void createUser() async {
    dynamic result = await _auth.createNewUser(
        emailController.text, passwordController.text);
    if (result == null) {
      print("email is not valid");
    } else {
      print(result.toString());
      nameController.clear();
      passwordController.clear();
      emailController.clear();
      Navigator.pop(context);
    }
  }
}
