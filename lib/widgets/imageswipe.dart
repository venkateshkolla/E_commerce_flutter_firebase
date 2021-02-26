import 'package:flutter/material.dart';

class Imageswipe extends StatefulWidget {
  final List imagelist;
  Imageswipe({this.imagelist});
  @override
  _ImageswipeState createState() => _ImageswipeState();
}

class _ImageswipeState extends State<Imageswipe> {
  int _selectedpage=0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: Stack(children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedpage=num;
              });

            },
            children: [
              for (int i = 0; i < widget.imagelist.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imagelist[i]}",
                    fit: BoxFit.cover,
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.imagelist.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width:_selectedpage==i? 35.0:10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                  )
              ],
            ),
          )
        ]));
  }
}
