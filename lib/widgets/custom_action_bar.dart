
import 'package:a_ecommerce/constans.dart';
import 'package:a_ecommerce/screens/cart_page.dart';
import 'package:a_ecommerce/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hastitle;
  final bool hasbackground;

  CustomActionBar(
      {this.title, this.hasBackArrow, this.hastitle, this.hasbackground});

  FireBaseServices _firebaseservices = FireBaseServices();

  final CollectionReference _userref =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hastitle = hastitle ?? true;
    bool _hasbackground = hasbackground ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasbackground
            ? LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.2)],
                begin: Alignment(0, 0),
                end: Alignment(0, 1))
            : null,
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  )),
            ),
          if (_hastitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldheading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Cart_Page(),
              ));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: StreamBuilder(
                    stream: _userref
                        .doc(_firebaseservices.getuserid())
                        .collection("Cart")
                        .snapshots(),
                    builder: (context, snapshot) {
                      int _totalitems = 0;

                      if (snapshot.connectionState == ConnectionState.active) {
                        List _documents = snapshot.data.docs;
                        _totalitems = _documents.length;
                      }

                      return Text(
                        // ignore: unnecessary_brace_in_string_interps
                        "${_totalitems}" ?? 0,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }
}
