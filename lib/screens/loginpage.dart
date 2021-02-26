import 'package:a_ecommerce/constans.dart';
import 'package:a_ecommerce/screens/registerpage.dart';
import 'package:a_ecommerce/widgets/custom_button.dart';
import 'package:a_ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Build an alert dialog to diaplay some errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(child: Text(error)),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("close dialouge "))
            ],
          );
        });
  }

//login with wmail and password
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to loading state
    setState(() {
      _loginformloaded = true;
    });

//run the create account method
    String _loginFeedback = await _loginAccount();

    //if string is not null,we got error while login account
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

//set the form to regular state
      setState(() {
        _loginformloaded = false;
      });
    }
  }

//default form loading state
  bool _loginformloaded = false;

//form input field values
  String _loginEmail = "";
  String _loginPassword = "";

//focus node for input fields

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 22),
                child: Text(
                  "Welcome user,\nLogin to your Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),

              Column(
                //input fields
                children: [
                  //email input
                  CustomInput(
                    hinttext: "email...",
                    onchanged: (value) {
                      _loginEmail = value;
                    },
                    textInputAction: TextInputAction.next,
                    onsubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                  ),

                  //password input
                  CustomInput(
                    hinttext: "password...",
                    isPasswordField: true,
                    onchanged: (value) {
                      _loginPassword = value;
                    },
                    onsubmitted: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode,
                  ),

                  //register button
                  Custombutton(
                    text: "Login",
                    onpressed: () {
                      _submitForm();

                      setState(() {
                        _loginformloaded = true;
                      });
                    },
                    isloaded: _loginformloaded,
                    outlinebutton: false,
                  ),
                ],
              ),

              //back to login

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Custombutton(
                  text: "Create New Account",
                  onpressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Registerpage()));
                  },
                  outlinebutton: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
