// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
// import 'package:renthouse/model/order_model.dart';

// class Order2 extends StatelessWidget {
//   const Order2({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Your Orders",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<OrderModel>>(
//         future: FirebaseFirestoreHelper.instance.getOrders(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text("No Order Found"),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               OrderModel order = snapshot.data![index];
//               return Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Order ${index + 1}", // Assuming you want to show order number
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                     Container(
//                       height: 200, // Adjust height as needed
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: order.image.length,
//                         itemBuilder: (context, imageIndex) {
//                           String imageUrl = order.image[imageIndex];
//                           return Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 6.0),
//                             child: Image.network(imageUrl),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
