import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CategoryModel {
  final List<dynamic> imageUrls;
  final String id;

  CategoryModel({required this.imageUrls, required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      imageUrls: json['imageUrls'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class FirebaseFirestoreHelper {
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Function to fetch category data
  Future<List<CategoryModel>> takePhotget() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("cat")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("gamer")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (!querySnapshot.exists) {
        print("Document does not exist");
        return [];
      }

      Map<String, dynamic>? data = querySnapshot.data();
      if (data != null) {
        return [CategoryModel.fromJson(data)];
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
}

class Take_Photo extends StatefulWidget {
  const Take_Photo({super.key});

  @override
  State<Take_Photo> createState() => _Take_PhotoState();
}

class _Take_PhotoState extends State<Take_Photo> {
  bool isLoading = false;
  List<XFile> imageFileList = [];
  List<CategoryModel> categories = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  // Fetch categories from Firestore
  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    try {
      categories = await FirebaseFirestoreHelper().takePhotget();
      // Debugging: print out the categories list and image URLs
      print('Categories: $categories');
    } catch (e) {
      print("Error fetching categories: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  // Pick images from the gallery
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(); // Pick multiple images

    if (pickedFiles != null) {
      setState(() {
        imageFileList = pickedFiles; // Save selected files to the list
      });
    }
  }

  // Upload files to Firebase Storage and return their download URLs
  Future<List<String>> _uploadFiles() async {
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFileList.length; i++) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('users') // Store images by users
            .child(user!.uid) // Use the user UID for organization
            .child('profile_images') // Folder for profile images
            .child(imageFileList[i].name); // Use the file name

        // Upload image to Firebase Storage
        await ref.putFile(File(imageFileList[i].path));

        // Get the download URL of the uploaded image
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl); // Add the image URL to the list
      }
      print('Uploaded Image URLs: $imageUrls');
    } catch (e) {
      print('Error uploading files: $e');
    }

    return imageUrls;
  }

  // Upload the photo URLs to Firestore and reload category data
  Future<void> _uploadPhoto() async {
    List<String> uploadedUrls = await _uploadFiles();

    if (uploadedUrls.isNotEmpty) {
      // Get the user document reference
      DocumentReference userDocRef = firestore
          .collection('cat') // Collection name
          .doc(user!.uid) // Use the user UID as the document ID
          .collection('gamer') // Subcollection name
          .doc(user!.uid); // Use the user UID as the document ID

      // Check if the user document exists
      DocumentSnapshot docSnapshot = await userDocRef.get();

      // If the document doesn't exist, create it
      if (!docSnapshot.exists) {
        await userDocRef.set({
          'imageUrls': uploadedUrls, // Add the image URLs to the Firestore document
          'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
        });
      } else {
        // If it exists, update the document
        await userDocRef.update({
          'imageUrls': uploadedUrls, // Add the image URLs to the Firestore document
          'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
        });
      }

      // After uploading, reload the category list to reflect the new data
      await getCategoryList();

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photos uploaded successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use FutureBuilder to ensure image is loaded when the page reloads
            FutureBuilder<List<CategoryModel>>(
              future: FirebaseFirestoreHelper().takePhotget(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading image: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // Debugging: Check image URL received from Firestore
                  List<dynamic> imageUrl = snapshot.data![0].imageUrls;
                  print('Received Image URL: $imageUrl');
        
                  if (imageUrl.isEmpty) {
                    return Text('Image URL is empty.');
                  }
        
                  return InkWell(
                    onTap: _pickImages,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(  
                        border: Border.all(width: 5, color: Colors.grey.shade700),
                        shape: BoxShape.circle
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl[0],height: 200,width: 200, fit: BoxFit.cover,
                          
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                } else {
               return    Center(
              child: InkWell(
                onTap: _pickImages, // Open gallery to pick multiple images
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.grey.shade700),
                    shape: BoxShape.circle,
                  ),
                  child: imageFileList.isEmpty
                      ? Icon(Icons.person_outline, color: Colors.grey.shade700, size: 200)
                      : CircleAvatar(
                          backgroundImage: FileImage(File(imageFileList[0].path)),
                          radius: 140,
                          
                        ),
                ),
              ),
            );
                }
              },
            ),
            SizedBox(height: 20),
            // Center(
            //   child: InkWell(
            //     onTap: _pickImages, // Open gallery to pick multiple images
            //     child: Container(
            //       padding: EdgeInsets.all(1),
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 5, color: Colors.grey.shade700),
            //         shape: BoxShape.circle,
            //       ),
            //       child: imageFileList.isEmpty
            //           ? Icon(Icons.person_outline, color: Colors.grey.shade700, size: 120)
            //           : CircleAvatar(
            //               backgroundImage: FileImage(File(imageFileList[0].path)),
            //               radius: 60,
            //             ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            // Show a button to upload photos
            InkWell(
              onTap: _uploadPhoto, // Upload images when tapped
              child: Container(
                height: height * 0.06,
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue.shade900,
                ),
                child: Center(
                  child: Text(
                    "Upload Photo",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
