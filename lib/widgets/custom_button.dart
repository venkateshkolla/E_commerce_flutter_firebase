import 'dart:ui';

import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  final String text;
  final Function onpressed;
  final bool outlinebutton;
  final bool isloaded;

  Custombutton({this.text, this.onpressed, this.outlinebutton, this.isloaded});

  @override
  Widget build(BuildContext context) {
    bool _outlinebutton = outlinebutton ?? false;
    bool _isloaded = isloaded ?? false;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 65,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _outlinebutton ? Colors.transparent : Colors.black,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(22)),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
        child: Stack(children: [
          Visibility(
            visible: _isloaded ? false : true,
            child: Center(
              child: Text(
                text ?? "text",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: _outlinebutton ? Colors.black : Colors.white),
              ),
            ),
          ),
          Visibility(
            visible: _isloaded,
            child: Center(
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator())),
          )
        ]),
      ),
    );
  }
}
