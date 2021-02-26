import 'dart:ui';

import 'package:a_ecommerce/constans.dart';
import 'package:a_ecommerce/services/firebase_services.dart';
import 'package:a_ecommerce/widgets/custom_action_bar.dart';
import 'package:a_ecommerce/widgets/imageswipe.dart';
import 'package:a_ecommerce/widgets/productsize.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productid;
  ProductPage({this.productid});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  FireBaseServices  _fireBaseServices=FireBaseServices();

  //user=>userid(document=>cart=>productid document)

//for getting user details

  String _selectedProductsize="0";

//make collection in firebase like cart
  Future _addtocart() {
    return _fireBaseServices.userref
        .doc(_fireBaseServices.getuserid())
        .collection("Cart")
        .doc(widget.productid)
        .set({"size": _selectedProductsize});
  }


   Future _addToSaved() {
    return _fireBaseServices.userref
        .doc(_fireBaseServices.getuserid())
        .collection("Saved")
        .doc(widget.productid)
        .set({"size": _selectedProductsize});
  }

  final SnackBar _snackbar=SnackBar(content: Text("Product add to the cart"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _fireBaseServices.productRef.doc(widget.productid).get(),
              builder: (context, snapshot) {
                //if snampshot has error
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Text("Error:${snapshot.error}"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  //firebase document data map
                  Map<String, dynamic> documentData = snapshot.data.data();

                  //list of images

                  List imagelist = documentData['images'];
                  List productsize = documentData['size'];

                  //set an initial size

                  _selectedProductsize=productsize[0];

                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      Imageswipe(
                        imagelist: imagelist,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, left: 24, right: 24, bottom: 4),
                        child: Text("${documentData['name']}" ?? "Product name",
                            style: Constants.boldheading),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 24),
                        child: Text(
                          "\$${documentData['price']}" ?? "price",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 24),
                        child: Text(
                          "${documentData['desc']}" ?? "Description",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 24),
                        child: Text(
                          "Selected size",
                          style: Constants.regularDarktext,
                        ),
                      ),
                      ProductSize(
                        productsize: productsize,
                        onSelected: (size){
                       _selectedProductsize=size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap:  () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_snackbar);
                            },
                                                          child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDCDCDC),
                                    borderRadius: BorderRadius.circular(12.0)),
                                alignment: Alignment.center,
                                child: Image(
                                  image: AssetImage("assets/images/asset-10.png"),
                                  height: 22.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async{
                                  await _addtocart();
                                  Scaffold.of(context).showSnackBar(_snackbar);

                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 16.0),
                                  height: 65.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }

                //loading state
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }),
          CustomActionBar(
            hasBackArrow: true,
            hastitle: false,
            hasbackground: false,
          )
        ],
      ),
    );
  }
}
