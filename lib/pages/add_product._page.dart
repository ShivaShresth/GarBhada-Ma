import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/constants/custom_theme.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/firebase_helper/firebase_auth/firebasee_auth_helper.dart';
import 'package:renthouse/google_map/direct_to_map.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/image_picker.dart';
import 'package:renthouse/pages/all_pages/upload_date_page.dart';
import 'package:renthouse/utils/utils.dart';
import 'package:renthouse/widgets/custom_rounded_btn.dart';
import 'package:renthouse/widgets/custom_text_field.dart';
import 'package:renthouse/widgets/drop.dart';
import 'package:renthouse/widgets/drop_down_btn.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String address = "",
      rent = "Not Avaliable",
      floor = "Not Avaliable",
      roadsize = "Not Avaliale",
      buildsqrt = "Not Avaliale",
      phonenumber = "",
      description = "Not Avaliable",
      housename = "Not Avaliable",
      landmark = "Not Avaliable",
      facebook = "Not Avaliable";
  TextEditingController addressController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  TextEditingController floorController = TextEditingController();

  TextEditingController roadsizeController = TextEditingController();

  TextEditingController buildsqrtftController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection =
      firestore.collection('categories');

  // Image_Picker imagePicker1 = Image_Picker();

  DateTime date = DateTime.now();
  var date1;

  int number = 0;
  int number1 = 0;
  int number2 = 0;

  int kitche = 0;

  List listItem4 = ['Occupied', 'UnOccupied'];

  List parking1 = [
    'Avaliable',
    'Not Avaliable',
    'Only Car',
    'Only Bike',
    'Both Car & Bike'
  ];

  List Negitoble1 = ['Yes', 'No'];

  List listItem2 = ['Yes', 'No'];
  bool a = false;
  bool b = true;

  String? parking;
  String? negitoble;
  String? nonveg;
  String? status;
  String statuss = "";
  String? roadtype;
  String? furnishing;
  String? type;
  double longitude = 0;
  double latitude = 0;
  bool Status = false;
  int view = 0;

  // final ImagePicker imagePicker = ImagePicker();
  // List<XFile> imageFileList = [];
  // List<bool> selectedItems = [];
  //   List<String>? imageUrlsss=[];

  // void selectImages() async {
  //   if (imageFileList.length < 6) {
  //     List<XFile>? selectedImages = await imagePicker.pickMultiImage();

  //     if (selectedImages != null &&
  //         (imageFileList.length + selectedImages.length) <= 6) {
  //       imageFileList.addAll(selectedImages);
  //       selectedItems.addAll(List.generate(selectedImages.length, (index) => false));
  //       setState(() {});
  //     }
  //   }
  // }

  // void deleteImage(int index) {
  //   setState(() {
  //     imageFileList.removeAt(index);
  //     selectedItems.removeAt(index);
  //   });
  // }

  Future<List<String>> _uploadFiles() async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFileList.length; i++) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('product')
            .child('/' + imageFileList[i].name);

        await ref.putFile(File(imageFileList[i].path));

        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      print('Uploaded Image URLs: $imageUrls');
    } catch (e) {
      print('Error uploading files: $e');
    }

    return imageUrls;
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<bool> selectedItems = [];
  int imageCounts = 0;
  List<String> imageUrls = [];
  bool isItemSaved = false;
  List<Map<String, dynamic>> tempImageUrls = [];
  List<Map<String, dynamic>> tempImageUrlss = [];

  void selectImages() async {
    if (imageFileList.length < 6) {
      List<XFile>? selectedImages = await imagePicker.pickMultiImage();

      if (selectedImages != null &&
          (imageFileList.length + selectedImages.length) <= 6) {
        imageFileList.addAll(selectedImages);
        selectedItems
            .addAll(List.generate(selectedImages.length, (index) => false));
        setState(() {
          imageCounts += 1;
        });
      }
    }
  }

  void deleteImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
      selectedItems.removeAt(index);
    });
  }

  // Future<void> _uploadFiles() async {
  //   List<Map<String, dynamic>> tempImageUrls = [];

  //   try {
  //     for (var i = 0; i < imageCounts; i++) {
  //       for (int j = 0; j < imageFileList.length; j++) {
  //         firebase_storage.Reference ref = firebase_storage
  //             .FirebaseStorage.instance
  //             .ref()
  //             .child('product')
  //             .child('/' + imageFileList[j].name);

  //         await ref.putFile(File(imageFileList[j].path));

  //         String imageUrl = await ref.getDownloadURL();
  //         tempImageUrls.add({'index': i, 'url': imageUrl});
  //       }
  //     }
  //     print('Uploaded Image URLs: $tempImageUrls');
  //     // Extract only the URLs as List<String>
  //     imageUrls =
  //         tempImageUrls.map<String>((entry) => entry['url'] as String).toList();

  //     // Update the Firestore document
  //   //  await _updateFirestoreDocument(tempImageUrls);
  //   } catch (e) {
  //     print('Error uploading files: $e');
  //   }
  // }

  // Future<void> _updateFirestoreDocument(
  //     List<Map<String, dynamic>> tempImageUrls) async {
  //   try {
  //     // Assuming you have access to the document ID (value.id)
  //     var value = 3;
  //     String documentId = "1";

  //     for (var entry in tempImageUrls) {
  //       await FirebaseFirestore.instance
  //           .collection('categories')
  //           .doc(FirebaseAuth.instance.currentUser!.uid)
  //           .update({
  //         'image.${entry['index']}': entry['url'],
  //       });
  //     }

  //     print('Firestore document updated with image URLs');
  //   } catch (e) {
  //     print('Error updating Firestore document: $e');
  //   }
  // }

  // Future<void> saveItem() async {
  //   setState(() {
  //     isItemSaved = true;
  //   });

  //   try {
  //     await _uploadFiles();

  //     await FirebaseFirestore.instance.collection('vegetables').add({
  //       'itemImageUrls': imageUrls,
  //     }).then((value) {
  //       setState(() {
  //         isItemSaved = false;
  //       });
  //       // Navigate to the next screen or perform any other action
  //     });
  //   } catch (e) {
  //     print('Save Item Error: $e');
  //     setState(() {
  //       isItemSaved = false;
  //     });
  //   }
  // }

  Future<void> saveItem() async {
    setState(() {
      isItemSaved = true;
    });

    try {
      await _uploadFiles();
      List<String?> imageUrlss = await _uploadFiles();

      //  FirebaseFirestoreHelper.instance.addProduct(image: image, landmark: landmark, rent: rent, kitchen: kitchen, bathroom: bathroom, bedroom: bedroom, parking: parking, negotiable: negotiable, nonveg: nonveg, name: name, date: date, status: status, longitude: longitude, latitude: latitude, floor: floor, roadtype: roadtype, type: type, furnishing: furnishing, roadsize: roadsize, buildupsqrft: buildupsqrft, phonenumber: phonenumber, description: description, address: address, isFavourite: isFavourite)
      CategoryModel categoryModel = CategoryModel(
          image: imageUrlss,
          landmark: landmarkController.text,
          rent: rentController.text ?? "Not available",
          kitchen: number.toString() ?? "Not available",
          bathroom: number1.toString(),
          bedroom: number2.toString(),
          parking: parking.toString(),
          negotiable: negitoble.toString(),
          name: houseNameController.text,
          nonveg: nonveg.toString(),
          date: date.toString(),
          status: status.toString(),
          longitude: longitude.toString(),
          latitude: latitude.toString(),
          floor: floorController.text.toString(),
          roadtype: roadtype.toString(),
          type: type.toString(),
          furnishing: furnishing.toString(),
          roadsize: roadsizeController.text.toString(),
          buildupsqrft: buildsqrtftController.text.toString(),
          phonenumber: phonenumberController.text.toString(),
          description: descriptionController.text.toString(),
                    address:_currentAddress.toLowerCase().toString(),

          // address: addressController.text,
          // price: 10,
          isFavourite: true,
          id: '1',
          view: view);
      await FirebaseFirestore.instance
          .collection('categories')
          .add(categoryModel.toMap())
          .then((value) {
        setState(() {
          isItemSaved = false;
        });

        //Now, update each document with the corresponding image index
        // for (var entry in tempImageUrls) {
        //   FirebaseFirestore.instance
        //       .collection('categories')
        //       .doc(value.id)
        //       .update({
        //     'image.${entry['index']}': entry['url'],
        //   });
        // }

        //  Navigate to the next screen or perform any other action
      });
    } catch (e) {
      print('Save Item Error: $e');
      setState(() {
        isItemSaved = false;
      });
    }
  }

  // void saveItem() async {
  //   setState(() {
  //     isItemSaved = true;
  //   });

  //   try {
  //     List<String> imageUrls = await _uploadFiles();
  //     await FirebaseFirestore.instance.collection('vegetables').add({
  //       'itemImageUrls': imageUrls,
  //     }).then((value) {
  //       setState(() {
  //         isItemSaved = false;
  //       });
  //       // Navigate to the next screen or perform any other action
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isItemSaved = false;
  //     });
  //   }
  // }

  Position? _currentLocation;

  late bool servicePermission = false;

  late LocationPermission permission;

  String? address1;

  String _currentAddress = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placesmarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placesmarks[0];
      Placemark placemark = placesmarks.first;
      String address =
          "${placemark.name}, ${placemark.locality}, ${placemark.country}";

      setState(() {
        // _currentAddress = "${place.locality},${place.country},${placemark.name}";
                _currentAddress = "${place.locality}";

        print("${placemark.name}, ${placemark.locality}, ${placemark.country}");
        address1 = address;
      });
    } catch (e) {
      print(e);
    }
  }

  //bool isItemSaved = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Information about House",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(border: Border.all()),
                  height: 300,
                  width: 500,
                  child: Column(
                    children: [
                      Text('${imageFileList.length}/6'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 4,
                                ),
                                itemCount: imageFileList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // Toggle the selection
                                            // selectedItems[index] = !selectedItems[index];
                                          });
                                        },
                                        child: Image.file(
                                          File(imageFileList[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (selectedItems[index])
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Delete the image
                                            deleteImage(index);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              if (imageFileList
                                  .isNotEmpty) // Display the upload button only if images are selected
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: MaterialButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      saveItem();
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (imageFileList.length <
                          6) // Display the add image button only if less than 6 images are selected
                        GestureDetector(
                          onTap: () {
                            selectImages();
                          },
                          child: Container(
                            height: 60,
                            width: 80,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 60),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                  //           Column(
                  //   children: [
                  //     Text('${imageFileList.length}/6'),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Stack(
                  //           children: [
                  //             GridView.builder(
                  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //                 crossAxisCount: 3,
                  //                 crossAxisSpacing: 10,
                  //                 mainAxisSpacing: 4,
                  //               ),
                  //               itemCount: imageFileList.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return Stack(
                  //                   alignment: Alignment.topRight,
                  //                   children: [
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           // Toggle the selection
                  //                           // selectedItems[index] = !selectedItems[index];
                  //                         });
                  //                       },
                  //                       child: Image.file(
                  //                         File(imageFileList[index].path),
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                     if (selectedItems[index])
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Icon(
                  //                           Icons.check_circle,
                  //                           color: Colors.green,
                  //                         ),
                  //                       ),
                  //                     Positioned(
                  //                       top: 0,
                  //                       right: 0,
                  //                       child: GestureDetector(
                  //                         onTap: () {
                  //                           // Delete the image
                  //                           deleteImage(index);
                  //                         },
                  //                         child: Icon(
                  //                           Icons.delete,
                  //                           color: Colors.red,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 );
                  //               },
                  //             ),
                  //             // if (imageFileList.isNotEmpty) // Display the upload button only if images are selected
                  //             //   Positioned(
                  //             //     bottom: 10,
                  //             //     right: 10,
                  //             //     child: MaterialButton(
                  //             //       color: Colors.blue,
                  //             //       onPressed: () {
                  //             //         saveItem();
                  //             //       },
                  //             //       child: Text("+"),
                  //             //     ),
                  //             //   ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     if (imageFileList.length < 6) // Display the add image button only if less than 6 images are selected
                  //       GestureDetector(
                  //         onTap: () {
                  //           selectImages();
                  //         },
                  //         child: Container(
                  //           height: 60,
                  //           width: 80,
                  //           color: Colors.black,
                  //           child: Center(
                  //             child: Text(
                  //               "+",
                  //               style: TextStyle(color: Colors.white, fontSize: 60),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     SizedBox(height: 6,),
                  //   ],
                  // ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding:
                                EdgeInsets.only(top: 5, left: 10, right: 10),
                            // height: MediaQuery.of(context).size.height ,
                            // width: MediaQuery.of(context).size.height,
                            // color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_city),
                                            SizedBox(width: 10),
                                            Expanded(child: Text("Address")),
                                            MaterialButton(
                                              
                                              minWidth: 120,
                                              color: Colors.blue,
                                              onPressed: () async {
                                                showAddressDialog(context);
                                        
                                                _currentLocation =
                                                    await _getCurrentLocation();
                                                await _getAddressFromCoordinates();
                                                setState(() {
                                                  a = _currentLocation ==
                                                      null; // Update 'a' based on whether location is available
                                                  longitude =
                                                      _currentLocation!.longitude;
                                                  latitude =
                                                      _currentLocation!.latitude;
                                                  b = false;
                                                });
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              child: b
                                                  ? Text("Press me")
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            // Text("Latitude= ",
                                                            //     style: TextStyle(
                                                            //         fontSize: 9,
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .bold)),
                                                            Text(
                                                              "${_currentAddress}",
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Icon(Icons.location_city),
                                      //     SizedBox(
                                      //       width: 10,
                                      //     ),
                                      //     Expanded(child: Text("Address")),
                                      //     Container(
                                      //         //margin: EdgeInsets.only(bottom: 8),
                                      //         padding: EdgeInsets.only(
                                      //             top: 0, bottom: 1, left: 8),
                                      //         height: 35,
                                      //         width: 120,
                                      //         decoration: BoxDecoration(
                                      //             border: Border.all(
                                      //                 color: Colors.grey),
                                      //             borderRadius:
                                      //                 BorderRadius.circular(4)),
                                      //         child: Center(
                                      //           child: TextFormField(
                                      //             controller: addressController,
                                      //             validator: (value) {
                                      //               if (value == null ||
                                      //                   value.isEmpty) {
                                      //                 return "Address Cannot be empty";
                                      //               } else {
                                      //                 return null;
                                      //               }
                                      //             },
                                      //             decoration: InputDecoration(
                                      //                 hintText: "Enter Address",
                                      //                 hintStyle: TextStyle(
                                      //                     fontSize: 14),
                                      //                 border: InputBorder.none
                                      //                 //border: OutlineInputBorder()
                                      //                 ),
                                      //           ),
                                      //         )),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.money),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Rent")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: rentController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Rent Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: "Enter Amount",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none
                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                //Kitchen Bathroom, BedRoom form
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.kitchen),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Kitchen")),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (number <= 0) {
                                                        number = 0;
                                                      } else {
                                                        number--;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("${number}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      number++;
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.green),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.bathroom),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Bathroom")),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (number1 <= 0) {
                                                        number1 = 0;
                                                      } else {
                                                        number1--;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("${number1}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      number1++;
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.green),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.bedroom_baby),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("BedRoom")),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (number2 <= 0) {
                                                        number2 = 0;
                                                      } else {
                                                        number2--;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.red),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("${number2}"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      number2++;
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.green),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ))),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ], //
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                //parking,negitoble,non-veg
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.local_parking),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Parking")),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Drop_Btn(
                                              items: parking1,
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  parking = value;
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.money),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Negitoble")),
                                          Drop_Btn(
                                              items: Negitoble1,
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  negitoble = value;
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.cabin),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Non-veg")),
                                          Drop_Btn(
                                              items: listItem2,
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  nonveg = value;
                                                });
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.date_range_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Starting Date")),
                                          ),
                                          Container(
                                              height: 35,
                                              width: 120,
                                              child: date_time(context)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.safety_check),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Status")),
                                          ),
                                          Drop_Btn(
                                              items: ['Occupied', "UnOccupied"],
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  status = value;
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.map_outlined),
                                          SizedBox(width: 10),
                                          Expanded(
                                              child:
                                                  Text("House Map Location")),
                                          MaterialButton(
                                            minWidth: 120,
                                            color: Colors.blue,
                                            onPressed: () async {
                                              showMapLoaderDialog(context);

                                              _currentLocation =
                                                  await _getCurrentLocation();
                                              await _getAddressFromCoordinates();
                                              setState(() {
                                                a = _currentLocation ==
                                                    null; // Update 'a' based on whether location is available
                                                longitude =
                                                    _currentLocation!.longitude;
                                                latitude =
                                                    _currentLocation!.latitude;
                                                b = false;
                                              });
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                            child: b
                                                ? Text("Press me")
                                                : Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("Latitude= ",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(
                                                              "${_currentLocation?.latitude}",
                                                              style: TextStyle(
                                                                  fontSize: 8)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Longitude= ",
                                                              style: TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(
                                                              "${_currentLocation?.longitude}",
                                                              style: TextStyle(
                                                                  fontSize: 8)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                //Floor road
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_city_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Road Type")),
                                          Drop_Btn(
                                              items: ['Pitched', 'Not Pitched'],
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  roadtype = value;
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.tab),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Furnishing")),
                                          Drop_Btn(
                                              items: [
                                                'Furnishing',
                                                'Not Furnishing'
                                              ],
                                              onItemSelected: (String? value) {
                                                setState(() {
                                                  furnishing = value;
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.type_specimen),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text("Type of Building")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Drop_Btn(
                                            items: [
                                              'Commerical ',
                                              'Residental ',
                                              'Industrail '
                                            ],
                                            onItemSelected: (String? value) {
                                              setState(() {
                                                type = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),

                                      // Row(
                                      //   children: [
                                      //     Text("Buildup(Sqr.Ft)"),
                                      //     TextFormField()
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text("Phone Number"),
                                      //     TextFormField()
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.house_outlined),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("House Name")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  controller:
                                                      houseNameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "House Name Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "House/Owner name",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12),
                                                      border: InputBorder.none
                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_city),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Floor")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  controller: floorController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Floor Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Ex:- 1,2,3,4 Floor",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none
                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.landscape),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Road Size")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      roadsizeController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Road Size Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: "Ex:- 10 meter",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none
                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_city),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Build Sqrtft")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 6),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      buildsqrtftController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Build Sqrtft Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: "Ex:- 123 Feet",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.landscape_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Land Mark")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  controller:
                                                      landmarkController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Land Mark Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: "Popular Place",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.mobile_friendly),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(child: Text("Phone Number")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      phonenumberController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Phone Number Cannot be empty";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText: "981234......",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none

                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.facebook),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text("FaceBook Link")),
                                          Container(
                                              //margin: EdgeInsets.only(bottom: 8),
                                              padding: EdgeInsets.only(
                                                  top: 0, bottom: 1, left: 8),
                                              height: 35,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: TextFormField(
                                                  // keyboardType: TextInputType.number,
                                                  controller:
                                                      facebookController,
                                                  // validator: (value) {
                                                  //   if (value == null ||
                                                  //       value.isEmpty) {
                                                  //     return "Phone Number Cannot be empty";
                                                  //   } else {
                                                  //     return null;
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "https/FaceBook Link",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14),
                                                      border: InputBorder.none

                                                      //border: OutlineInputBorder()
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 5,
                                          blurRadius: 6,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Description")),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            color: Colors.white,
                                            height: 160,
                                            width: double.infinity,
                                            child: TextField(
                                              controller: descriptionController,
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Enter the Full Detail.......",
                                                  hintStyle:
                                                      TextStyle(fontSize: 14),
                                                  border: OutlineInputBorder()),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 0,
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 10),
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 10, vertical: 20),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Colors.white,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.black.withOpacity(0.1),
                        //           spreadRadius: 5,
                        //           blurRadius: 6,
                        //           offset: Offset(2, 2),
                        //         )
                        //       ]),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Icon(Icons.house_outlined),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("House Name")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 8),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                   controller: houseNameController,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "House Name Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                        hintText: "House/Owner name",
                        //                             hintStyle: TextStyle(fontSize: 12),
                        //                             border:InputBorder.none
                        //                       //border: OutlineInputBorder()
                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(Icons.location_city),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("Floor")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 8),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                   controller: floorController,
                        //                   keyboardType: TextInputType.number,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "Floor Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                       hintText: "Ex:- 1,2,3,4 Floor",
                        //                             hintStyle: TextStyle(fontSize: 14),
                        //                             border:InputBorder.none
                        //                       //border: OutlineInputBorder()
                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(Icons.landscape),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("Road Size")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 8),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                                                               keyboardType: TextInputType.number,

                        //                   controller: roadsizeController,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "Road Size Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                       hintText: "Ex:- 10 meter",
                        //                             hintStyle: TextStyle(fontSize: 14),
                        //                             border:InputBorder.none
                        //                       //border: OutlineInputBorder()
                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(Icons.location_city),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("Build Sqrtft")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 6),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                                                               keyboardType: TextInputType.number,

                        //                   controller: buildsqrtftController,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "Build Sqrtft Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                       hintText: "Ex:- 123 Feet",
                        //                             hintStyle: TextStyle(fontSize: 14),
                        //                       border:InputBorder.none

                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(Icons.landscape_rounded),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("Land Mark")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 8),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                   controller: landmarkController,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "Land Mark Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                       hintText: "Popular Place",
                        //                             hintStyle: TextStyle(fontSize: 14),
                        //                                                                           border:InputBorder.none

                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Icon(Icons.mobile_friendly),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           Expanded(child: Text("Phone Number")),
                        //           Container(
                        //               //margin: EdgeInsets.only(bottom: 8),
                        //               padding: EdgeInsets.only(
                        //                   top: 0, bottom: 1, left: 8),
                        //               height: 35,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                   border:
                        //                       Border.all(color: Colors.grey),
                        //                   borderRadius:
                        //                       BorderRadius.circular(4)),
                        //               child: Center(
                        //                 child: TextFormField(
                        //                   keyboardType: TextInputType.number,
                        //                   controller: phonenumberController,
                        //                   validator: (value) {
                        //                     if (value == null ||
                        //                         value.isEmpty) {
                        //                       return "Phone Number Cannot be empty";
                        //                     } else {
                        //                       return null;
                        //                     }
                        //                   },
                        //                   decoration: InputDecoration(
                        //                       hintText: "981234......",
                        //                             hintStyle: TextStyle(fontSize: 14),
                        //                                                     border:InputBorder.none

                        //                       //border: OutlineInputBorder()
                        //                       ),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(horizontal: 10),
                        //   padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: Colors.white,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.black.withOpacity(0.1),
                        //           spreadRadius: 5,
                        //           blurRadius: 6,
                        //           offset: Offset(2, 2),
                        //         )
                        //       ]),
                        //   child: SingleChildScrollView(
                        //     child: Column(
                        //       children: [
                        //         Align(
                        //             alignment: Alignment.topLeft,
                        //             child: Text("Description")),
                        //         SizedBox(
                        //           height: 10,
                        //         ),
                        //         Container(
                        //             color: Colors.white,
                        //             height: 160,
                        //             width: double.infinity,
                        //             child: TextField(
                        //               controller: descriptionController,
                        //               maxLines: 5,
                        //               decoration: InputDecoration(
                        //                   hintText: "Enter the Full Detail.......",
                        //                               hintStyle: TextStyle(fontSize: 14),
                        //                   border: OutlineInputBorder()),
                        //             )),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () async {
                            List<String?> imageUrlss = await _uploadFiles();

                            setState(() {
                                                  address=_currentAddress.toLowerCase().toString();

                              //address = addressController.text;
                              phonenumber = phonenumberController.text;
                              rent = rentController.text;
                              floor = floorController.text;
                              roadsize = roadsizeController.text;
                              buildsqrt = buildsqrtftController.text;
                              description = descriptionController.text;
                              housename = houseNameController.text;
                              landmark = landmarkController.text;
                              facebook = facebookController.text;
                              longitude == null ? "${1}" : "${2}";

                              if (status == "Occupied") {
                                Status = false;
                                print("heloses it ok");
                              } else {
                                Status = true;
                                print("why it ok");
                              }

                              print("heloses${longitude}");
                            });

                            print("helso${latitude}");
                            if (imageUrlss.isEmpty) {
                              showMessage("Image Cannot be Empty");
                            } 
                            
                            // else if (address.isEmpty) {
                            //   showMessage("Address Cannot be Empty");
                            // }
                            
                             else if (phonenumber.isEmpty) {
                              showMessage("PhoneNumber Cannot be Empty");
                            } else {
                              FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              DocumentReference doc = productCollection.doc();
                              User? user = FirebaseAuth.instance.currentUser;

                              print("heils${floor.toString()}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Upload_Data_Page(
                                            image: imageUrlss,
                                            landmark:
                                                landmark.toString().isEmpty
                                                    ? "Not Avaliable"
                                                    : "${landmark.toString()}",
                                            facebook:
                                                facebook.toString().isEmpty
                                                    ? "Not Avaliable"
                                                    : "${facebook.toString()}",
                                            rent: rent.toString().isEmpty
                                                ? "Not Avaliable"
                                                : "${rent}",
                                            kitchen: number.toString().isEmpty
                                                ? "Not Avaliable"
                                                : "${number.toString()}",
                                            bathroom: number1.toString().isEmpty
                                                ? "Not Avaliable"
                                                : "${number1.toString()}",
                                            bedroom: number2.toString().isEmpty
                                                ? "Not Avaliable"
                                                : "${number2.toString()}",
                                            parking: parking == null
                                                ? "Not Avaliable"
                                                : "${parking.toString()}",
                                            negotiable: negitoble == null
                                                ? "Not Avaliable"
                                                : "${negitoble.toString()}",
                                            name: housename.toString().isEmpty
                                                ? "Not Avaliable"
                                                : "${housename.toString()}",
                                            nonveg: nonveg == null
                                                ? "Not Avaliable"
                                                : "${nonveg.toString()}",
                                            date: date.toString(),
                                            status: status == null
                                                ? "Not Avaliable"
                                                : "${status.toString()}",
                                            longitude: longitude.toString(),
                                            latitude: latitude.toString(),
                                            floor: floorController.text
                                                    .toString()
                                                    .isEmpty
                                                ? "Not Avaliable"
                                                : "${floor.toString()}",
                                            roadtype: roadtype == null
                                                ? "Not Avaliable"
                                                : "${roadtype.toString()}",
                                            type: type == null
                                                ? "Not Avaliable"
                                                : "${type.toString()}",
                                            furnishing: furnishing == null
                                                ? "Not Avaliable"
                                                : "${furnishing.toString().toLowerCase()}",
                                            roadsize: roadsize.isEmpty
                                                ? "Not Avaliable"
                                                : "${roadsize.toString()}",
                                            buildupsqrft: buildsqrtftController
                                                    .text
                                                    .toString()
                                                    .isEmpty
                                                ? "Not Avaliable"
                                                : "${buildsqrt.toString()}",
                                            phonenumber: phonenumberController
                                                .text
                                                .toString(),
                                            description: descriptionController
                                                    .text
                                                    .toString()
                                                    .isEmpty
                                                ? "Not Avaliable"
                                                : "${description.toString()}",
                                                address: _currentAddress
                                                    .toString()
                                                    .toLowerCase()
                                                    .isEmpty
                                                ? "Not Avaliable"
                                                : "${address.toString()}",
                                            // address: addressController.text
                                            //         .toString()
                                            //         .toLowerCase()
                                            //         .isEmpty
                                            //     ? "Not Avaliable"
                                            //     : "${address.toString()}",
                                            // price: 10,
                                            isFavourite: Status,
                                            id: user!.uid,
                                            view: view,
                                            viewId: doc.id,
                                          )));
                            }

                            //List<String?> imageUrls = await _uploadFiles();
                          },
                          child: Text("press "),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomRoundedButton(
                            title: "Next",
                            onPressed: () async {
                              // await _uploadFiles();
                              saveItem();
                              List<String?> imageUrls = await _uploadFiles();
                              print(imageUrls);

                              // FirebaseFirestoreHelper.instance.addProduct("" ,locationController.text, 10, descriptionController.text, "the", true, rentController.text, locationController.text, "20", "house", locationController.text, "2", "yes", "pitch", "yes", "yes", "10101", "12", "yes", "bedroom", "parking", "roadsize", "longitude", "latitude",);

                              // FirebaseFirestoreHelper.instance.addProduct(
                              //     image:imageUrls,
                              //     landmark: landmarkController.text,
                              //     rent: rentController.text??"Not available",
                              //     kitchen: number.toString()??"Not available",
                              //     bathroom: number1.toString(),
                              //     bedroom: number2.toString(),
                              //     parking: parking.toString(),
                              //     negotiable: negitoble.toString(),
                              //     name: houseNameController.text,
                              //     nonveg: nonveg.toString(),
                              //     date: date.toString(),
                              //     status: status.toString(),
                              //     longitude: longitude.toString(),
                              //     latitude: latitude.toString(),
                              //     floor: floorController.text.toString(),
                              //     roadtype: roadtype.toString(),
                              //     type: type.toString(),
                              //     furnishing: furnishing.toString(),
                              //     roadsize: roadsizeController.text.toString(),
                              //     buildupsqrft:
                              //         buildsqrtftController.text.toString(),
                              //     phonenumber:
                              //         phonenumberController.text.toString(),
                              //     description:
                              //         descriptionController.text.toString(),
                              //     address: addressController.text,
                              //    // price: 10,
                              //     isFavourite: true);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget date_time(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          width: 2,
          color: Color(0xffC5C5C5),
        ),
      ),
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2023),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
            date1 = date;
            print("the process${date1}");
          });
        },
        child: Text(
          'Date:${date.year}/${date.day}/${date.month}',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
