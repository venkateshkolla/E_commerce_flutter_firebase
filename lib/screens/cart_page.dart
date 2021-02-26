
import 'package:a_ecommerce/screens/product_page.dart';
import 'package:a_ecommerce/services/firebase_services.dart';
import 'package:a_ecommerce/widgets/custom_action_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Cart_Page extends StatefulWidget {
  @override
  _Cart_PageState createState() => _Cart_PageState();
}

// ignore: camel_case_types
class _Cart_PageState extends State<Cart_Page> {
  FireBaseServices _fireBaseServices = FireBaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _fireBaseServices.userref
                  .doc(_fireBaseServices.getuserid())
                  .collection("Cart")
                  .get(),
              builder: (context, snapshot) {
                //if snampshot has error
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Text("Error:${snapshot.error}"),
                  );
                }

//collection data ready to diaplay

                if (snapshot.connectionState == ConnectionState.done) {
                  //diaplay the data inside the list view
                  return ListView(
                    padding: EdgeInsets.only(top: 108.0, bottom: 12.0),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    productid: document.id,
                                  )));
                        },
                        child: FutureBuilder(
                            future: _fireBaseServices.productRef
                                .doc(document.id)
                                .get(),
                            builder: (context, productSnap) {


                             if(productSnap.hasError){
                               return Container(
                               child: Center(child: Text("${productSnap.hasError}")),
                               );
                             }

                             if(productSnap.connectionState ==ConnectionState.done) {
                            Map _productMap = productSnap.data.data();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${_productMap['images'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_productMap['name']}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 4.0,
                                          ),
                                          child: Text(
                                            "\$${_productMap['price']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "Size - ${document.data()['size']}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }

                             return Container(
                               child: Center(child: CircularProgressIndicator()),

                             );



                            }),
                      );
                    }).toList(),
                  );
                }

                //loading state
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }),
          CustomActionBar(
            hasBackArrow: true,
            title: "Cart",
          )
        ],
      ),
    );
  }
}