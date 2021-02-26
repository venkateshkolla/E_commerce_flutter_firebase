import 'package:a_ecommerce/constans.dart';
import 'package:a_ecommerce/screens/product_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

   final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard({this.onPressed, this.imageUrl, this.title, this.price, this.productId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    productid: productId,
                                  )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0)),
                          height: 350.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          //  child:Text("Name:${document.data()['name']}"),
                          child: Stack(
                            children: [
                              Container(
                                height: 350,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    "$imageUrl",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                       title
                                            ,
                                        style: Constants.regularHeading,
                                      ),
                                      Text(
                                        price
                                        ,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
  }
}