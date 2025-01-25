// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/bottom_navigation_bar.dart';

class Upload_Data_Page extends StatefulWidget {
  final List<dynamic> image;
  String id;
  String nonveg;
  String name;
  //double price;
  String description;
  String status;
  bool isFavourite;
  String rent;
  String address;
  String date;
  String type;
  String landmark;
  String floor;
  String negotiable;
  String roadtype;
  String furnishing;
  String buildupsqrft;
  String phonenumber;
  String kitchen;
  String bathroom;
  String bedroom;
  String parking;
  String roadsize;
  String longitude;
  String latitude;
  int view;
  String? viewId;
  String? facebook;
  Upload_Data_Page({
    Key? key,
    required this.image,
    required this.id,
    required this.nonveg,
    required this.name,
    required this.description,
    required this.status,
    required this.isFavourite,
    required this.rent,
    required this.address,
    required this.date,
    required this.type,
    required this.landmark,
    required this.floor,
    required this.negotiable,
    required this.roadtype,
    required this.furnishing,
    required this.buildupsqrft,
    required this.phonenumber,
    required this.kitchen,
    required this.bathroom,
    required this.bedroom,
    required this.parking,
    required this.roadsize,
    required this.longitude,
    required this.latitude,
    required this.facebook,
    this.view=0,
    this.viewId,
  }) : super(key: key);

  @override
  State<Upload_Data_Page> createState() => _Upload_Data_PageState();
}

class _Upload_Data_PageState extends State<Upload_Data_Page> {
  bool isItemSaved=false;
  
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<bool> selectedItems = [];
  int imageCounts = 0;
  List<String> imageUrls = [];

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


    Future<void> saveItem() async {
    setState(() {
      isItemSaved = true;
    });

    try {
            FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference productCollection = firestore.collection('categories');
 CollectionReference productCollection = firestore.collection('cat').doc(FirebaseAuth.instance.currentUser!.uid).collection("cats");

// Create a new document reference with an automatically generated ID
// DocumentReference doc = productCollection.doc();
DocumentReference doc = productCollection.doc();

// Get the automatically generated ID
// String id = doc.id;

  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //     DocumentReference documentReference = _firebaseFirestore
  //         .collection("cat")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("cats")
  //         .doc();

// Upload files and get image URLs
await _uploadFiles();
List<String?> imageUrlss = await _uploadFiles();

// Create a CategoryModel instance with the automatically generated ID
CategoryModel categoryModel = CategoryModel(
  image: widget.image,
  landmark: widget.landmark,
  rent: widget.rent,
  kitchen: widget.kitchen,
  bathroom: widget.bathroom,
  bedroom: widget.bedroom,
  parking: widget.parking,
  negotiable: widget.negotiable,
  name: widget.name,
  nonveg: widget.nonveg,
  date: widget.date,
  status: widget.status,
  longitude: widget.longitude,
  latitude: widget.latitude,
  floor: widget.floor,
  roadtype: widget.roadtype,
  type: widget.type,
  furnishing: widget.furnishing.toLowerCase(),
  roadsize: widget.roadsize,
  buildupsqrft: widget.buildupsqrft,
  phonenumber: widget.phonenumber,
  description: widget.description,
  address: widget.address,
  isFavourite: widget.isFavourite,
  id: widget.id, // Set the generated ID here
  view: widget.view,
  facebook: widget.facebook,
  viewId: doc.id
);
print("heien${doc.id}");
print(widget.viewId);
// Add the CategoryModel instance to Firestore
await doc.set(categoryModel.toMap()).then((value) {
  setState(() {
    isItemSaved = false;
  });
});

    } catch (e) {
      print('Save Item Error: $e');
      setState(() {
        isItemSaved = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
         

            // color: Colors.black.withOpacity(0.8),
            child: Column(
              children: [
                Container(

                 
                  // color: Colors.green,
                  child: Column(
                    children: [
                      Container(
                          color: Colors.blue,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Image.network(widget.image[0],height: 400,width: 600,fit: BoxFit.cover,)),
                      //Text(widget.image[0]),
                      SingleChildScrollView(
                        child: Container(
                         
                     
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Id Number ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.id}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Non Veg ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.nonveg}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.2,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Name ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.name}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.3,
                                        ),
                                    
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Status ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.status}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.5,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child:
                                                      Text("isFavourite ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.isFavourite}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.7,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Rent ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.rent}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.2,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Address ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.address}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Date ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.date}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Type ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.type}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.6,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Land Mark ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.landmark}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Floor ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.floor}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Negotiable ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.negotiable}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("RoadyType ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.roadtype}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Furnishing ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.furnishing}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child:
                                                      Text("BuildUpSqrft ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.buildupsqrft}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 102,
                                                  // color: Colors.pink,
                                                  child: Text("PhoneNumber->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.phonenumber}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Kitchen ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.kitchen}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Bathroom ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.bathroom}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Bed Room ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.bedroom}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Parking ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.parking}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Road Size ->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.roadsize}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),

                                        
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child: Text("Facebook->")),
                                              Expanded(
                                                child: Container(
                                                    //  color: Colors.green,
                                                    width: 150,
                                                    child: Text(
                                                      "${widget.facebook}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                            Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          color: Colors.white,
                                          width: 400,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  width: 100,
                                                  // color: Colors.pink,
                                                  child:
                                                      Text("Description")),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                                                   color: Colors.black,
                                                   height: 160,
                                                  width: 280,
                                                  child: Container(
                                                                                                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),

                                                    color: Colors.white,
                                                    child: Text(
                                                      "${widget.description}",
                                                      maxLines: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Back"),
                            ),
                            Icon(Icons.home_outlined,color: Colors.blue,size: 40,),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                showLoaderDialog(context);
                                saveItem();
                                //Navigator.of(context,rootNavigator: true).pop();
                                showMessage("Upload Data Sucessfully");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottom_Navigation_Bar()));
//Navigator.of(context).pop();

                              },
                              child: Text("Upload"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
