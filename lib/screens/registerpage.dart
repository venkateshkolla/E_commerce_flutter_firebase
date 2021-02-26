import 'package:a_ecommerce/widgets/custom_button.dart';
import 'package:a_ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
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

//create a new user account
  Future<String> _createaccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
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
      _registerFormLoading = true;
    });

//run the create account method
    String _createAccountFeedBack = await _createaccount();

    //if string is not null,we got error while create account
    if (_createAccountFeedBack != null) {
      _alertDialogBuilder(_createAccountFeedBack);

//set the form to regular state
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // the string was null, user is login
      Navigator.of(context).pop(context);
    }
  }

//default form loading state
  bool _registerFormLoading = false;

//form input field values
  String _registerEmail = "";
  String _registerPassword = "";

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
              //heading
              Container(
                padding: EdgeInsets.only(top: 22),
                child: Text(
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,
                ),
              ),

              //input fields

              Column(
                //input fields
                children: [
                  //email input
                  CustomInput(
                    hinttext: "email...",
                    onchanged: (value) {
                      _registerEmail = value;
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
                      _registerPassword = value;
                    },
                    onsubmitted: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode,
                  ),

                  //register button
                  Custombutton(
                    text: "Create New Account",
                    onpressed: () {
                      _submitForm();

                      setState(() {
                        _registerFormLoading = true;
                      });
                    },
                    isloaded: _registerFormLoading,
                    outlinebutton: false,
                  ),
                ],
              ),

              //back to login
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Custombutton(
                  text: "Back to Login",
                  onpressed: () {
                    Navigator.of(context).pop();
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
