// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: FirebaseFirestore.instance.collection('vegetables').snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text("No data available"),
//             );
//           }

//           return LayoutBuilder(builder: (context, constraints) {
//             return constraints.maxWidth < 600
//                 ? Container(
//                     child: ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         return cartItemWidget(context, snapshot.data!.docs[index]);
//                       },
//                     ),
//                   )
//                 : Container(
//                     child: snapshot.data!.docs.length > 0
//                         ? GridView.builder(
//                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 4,
//                               mainAxisSpacing: 0.02,
//                               crossAxisSpacing: 0.02,
//                             ),
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return cartItemWidget(context, snapshot.data!.docs[index]);
//                             },
//                           )
//                         : Container(
//                             child: Center(
//                               child: Text(
//                                 'No item found',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ),
//                           ),
//                   );
//           });
//         },
//       ),
//     );
//   }
// Widget cartItemWidget(BuildContext context, DocumentSnapshot<Map<String, dynamic>> snapshot) {
//   List<dynamic> imageUrls = snapshot['itemImageUrls'];
//   String name = snapshot['name']; // Assume same name for all images

//   return Card(
//     child: Container(
//       width: MediaQuery.of(context).size.width * 0.2,
//       height: MediaQuery.of(context).size.height * 0.3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(name), // Display the name associated with all images
//           SizedBox(height: 8), // Add some spacing between name and images
//           Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: imageUrls.length,
//               itemBuilder: (context, index) {
//                 String imageUrl = imageUrls[index];
//                 return Padding(
                  
//                   padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 3),
//                   child: Image.network(imageUrl),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }





// }
