// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class Products {
//   final List<String> image;
//   final String landmark;
//   final String rent;
//   final String kitchen;
//   // Add other fields here

//   Products({
//     required this.image,
//     required this.landmark,
//     required this.rent,
//     required this.kitchen,
//     // Add other fields here
//   });

//   // Convert the model to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'image': image,
//       'landmark': landmark,
//       'rent': rent,
//       'kitchen': kitchen,
//       // Map other fields here
//     };
//   }
// }

// class ImagePickerScreen extends StatefulWidget {
//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }

// class _ImagePickerScreenState extends State<ImagePickerScreen> {
//   final ImagePicker imagePicker = ImagePicker();
//   List<XFile> imageFileList = [];
//   List<bool> selectedItems = [];
//   int imageCounts = 0;
//   List<String> imageUrls = [];
//   bool isItemSaved = false;

//   void selectImages() async {
//     if (imageFileList.length < 6) {
//       List<XFile>? selectedImages = await imagePicker.pickMultiImage();

//       if (selectedImages != null &&
//           (imageFileList.length + selectedImages.length) <= 6) {
//         imageFileList.addAll(selectedImages);
//         selectedItems.addAll(List.generate(selectedImages.length, (index) => false));
//         setState(() {
//           imageCounts += 1;
//         });
//       }
//     }
//   }

//   void deleteImage(int index) {
//     setState(() {
//       imageFileList.removeAt(index);
//       selectedItems.removeAt(index);
//     });
//   }

//   Future<void> _uploadFiles() async {
//     List<Map<String, dynamic>> tempImageUrls = [];

//     try {
//       for (var i = 0; i < imageCounts; i++) {
//         for (int j = 0; j < imageFileList.length; j++) {
//           firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//               .ref()
//               .child('product')
//               .child('/' + imageFileList[j].name);

//           await ref.putFile(File(imageFileList[j].path));

//           String imageUrl = await ref.getDownloadURL();
//           tempImageUrls.add({'index': i, 'url': imageUrl});
//         }
//       }
//       print('Uploaded Image URLs: $tempImageUrls');
//       setState(() {
//         // Extract only the URLs as List<String>
//         imageUrls = tempImageUrls.map<String>((entry) => entry['url'] as String).toList();
//       });
//     } catch (e) {
//       print('Error uploading files: $e');
//     }
//   }

//   Future<void> saveItem() async {
//     setState(() {
//       isItemSaved = true;
//     });

//     try {
//       await _uploadFiles();

//       Products product = Products(
//         image: imageUrls,
//         landmark: "landmark",
//         rent: "rent",
//         kitchen: "kitchen",
//         // Set other fields here
//       );

//       await FirebaseFirestore.instance.collection('game').add(product.toMap()).then((value) {
//         setState(() {
//           isItemSaved = false;
//         });
//         // Navigate to the next screen or perform any other action
//       });
//     } catch (e) {
//       print('Save Item Error: $e');
//       setState(() {
//         isItemSaved = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text('${imageFileList.length}/6'),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Stack(
//                   children: [
//                     GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 4,
//                       ),
//                       itemCount: imageFileList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Stack(
//                           alignment: Alignment.topRight,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   // Toggle the selection
//                                   // selectedItems[index] = !selectedItems[index];
//                                 });
//                               },
//                               child: Image.file(
//                                 File(imageFileList[index].path),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             if (selectedItems[index])
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   Icons.check_circle,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   // Delete the image
//                                   deleteImage(index);
//                                 },
//                                 child: Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     if (imageFileList.isNotEmpty) // Display the upload button only if images are selected
//                       Positioned(
//                         bottom: 10,
//                         right: 10,
//                         child: MaterialButton(
//                           color: Colors.blue,
//                           onPressed: () {
//                             saveItem();
//                           },
//                           child: Text("+"),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             if (imageFileList.length < 6) // Display the add image button only if less than 6 images are selected
//               GestureDetector(
//                 onTap: () {
//                   selectImages();
//                 },
//                 child: Container(
//                   height: 60,
//                   width: 80,
//                   color: Colors.black,
//                   child: Center(
//                     child: Text(
//                       "+",
//                       style: TextStyle(color: Colors.white, fontSize: 60),
//                     ),
//                   ),
//                 ),
//               ),
//             SizedBox(
//               height: 6,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 saveItem();
//               },
//               child: Text("press me"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
