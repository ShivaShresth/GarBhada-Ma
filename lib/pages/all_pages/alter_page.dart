import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';

class Alter_Page extends StatelessWidget {
  const Alter_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Orders",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('userOrders').doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Order Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              CategoryModel category = CategoryModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red, width: 2.3),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        color: Colors.red.withOpacity(0.5),
                        child: Image.network(
                          category.image[0], // Using the first image only
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
