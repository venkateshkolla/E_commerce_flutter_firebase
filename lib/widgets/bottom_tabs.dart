import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabpressed;
  BottomTabs({this.selectedTab,this.tabpressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedtab = 0;

  var icons1 = Icons.home;

  @override
  Widget build(BuildContext context) {
    _selectedtab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 30.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomtabBtn(
            iconpath: Icons.home,
            selected: _selectedtab == 0 ? true : false,
            onpressed: () {
             widget.tabpressed(0);
            },
          ),
          BottomtabBtn(
            iconpath: Icons.search,
            selected: _selectedtab == 1 ? true : false,
           onpressed: () {
             widget.tabpressed(1);
            },
          ),
          BottomtabBtn(
            iconpath: Icons.favorite,
            selected: _selectedtab == 2 ? true : false,
            onpressed: () {
             widget.tabpressed(2);
            },
          ),
          BottomtabBtn(
            iconpath: Icons.logout,
            selected: _selectedtab == 3 ? true : false,
            onpressed: () {
             FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomtabBtn extends StatelessWidget {
  final IconData iconpath;
  final bool selected;
  final Function onpressed;

  BottomtabBtn({this.iconpath, this.selected, this.onpressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: _selected ? Theme.of(context).accentColor : Colors.transparent,
          width: 2.0,
        ))),
        child: Icon(
          iconpath ?? Icons.home,
          size: 26.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
