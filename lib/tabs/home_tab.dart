
import 'package:a_ecommerce/widgets/custom_action_bar.dart';
import 'package:a_ecommerce/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hometab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          
          FutureBuilder<QuerySnapshot>(
              future: _productRef.get(),
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
                      return ProductCard( 
                        title: document.data()['name'],
                        imageUrl: document.data()['images'][0],
                        price: "\$${document.data()['price']}",
                        productId:document.id,
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
            title: "Home",
            hasBackArrow: false,
            hastitle: true,
          ),
        ],
      ),
    );
  }
}
