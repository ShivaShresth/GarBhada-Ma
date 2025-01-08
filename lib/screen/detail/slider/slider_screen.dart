import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/photo_view_page.dart';
import 'package:renthouse/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SliderScreen extends StatefulWidget {
  final CategoryModel? categoryModel;
  final int? plus;

  SliderScreen({Key? key, this.categoryModel, this.plus}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List<String>? imageList;
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  double? num;
  List<String> displayedImages = [];
  bool showAllImages = false;
  int? plus; // Declare plus here

  @override
  void initState() {
    super.initState();
    loadImages();
    fetchPlusValue(); // Fetch plus value when the screen initializes
  }

  void loadImages() async {
    String? userNumber = await SharedPreferenceHelper().getNumber();
    num = double.tryParse(userNumber ?? '') ?? 0;

    imageList = widget.categoryModel?.image.cast<String>() ?? [];
    updateDisplayedImages();
    setState(() {});
  }

  void updateDisplayedImages() {
    displayedImages = showAllImages ? imageList! : imageList!.take(6).toList();
  }

  // Fetch the plus value from Firestore
  void fetchPlusValue() async {
    // final userId = FirebaseAuth.instance.currentUser?.uid;
    // if (userId == null) {
    //     print("User is not logged in.");
    //     return;
    // }

    // print("Fetching data for user ID: $userId");
    // print("Document path: cat/$userId/cats/${widget.categoryModel!.id}");

    // DocumentSnapshot snapshot = await FirebaseFirestore.instance
    //     .collection('cat')
    //     .doc(userId)
    //     .collection('cats')
    //     .doc(widget.categoryModel!.id)
    //     .get();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference productCollection = firestore.collection('categories');
 CollectionReference productCollection = firestore.collection('cat').doc(FirebaseAuth.instance.currentUser!.uid).collection("cats");

// Create a new document reference with an automatically generated ID
// DocumentReference doc = productCollection.doc();
DocumentReference doc = productCollection.doc();

     final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User is not authenticated");
        return; 
      }

      DocumentReference docRef = FirebaseFirestore.instance
          .collection("cat")
          .doc(user.uid)
          .collection("cats")
          .doc(widget.categoryModel!.description);

      DocumentSnapshot snapshot = await docRef.get();

      // if (!snapshot.exists) {
      //   print("Document not found: $viewId");
      //   return; 
      // }

    if (snapshot.exists) {
        // Use the data() method to get the content of the snapshot
        var data = snapshot.data();
        if (data != null && data is Map<String, dynamic>) {
            setState(() {
                plus = data['view'] ??0; // Access the 'view' field from the document data
                print("Fetched plus value: $plus");
            });
        } else {
            print("No valid data found in the document.");
        }
    } else {
            print("thess ${doc.id}");

      print("thess ${snapshot}");
        print("No data found for user: ${widget.categoryModel!.description}");
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.categoryModel != null)
            Stack(
              children: [
                CarouselSlider(
  items: displayedImages
      .asMap() // Use asMap to get index
      .entries
      .map((entry) {
        int index = entry.key; // Get the index
        String imagePath = entry.value; // Get the image path

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoViewPage(
                  photos: displayedImages,  // Pass the list of image URLs
                  index: index,              // Use the correct index
                ),
              ),
            );
          },
          child: Image.network(imagePath, fit: BoxFit.cover, width: double.infinity),
        );
      })
      .toList(),
  carouselController: carouselController,
  options: CarouselOptions(
    scrollPhysics: BouncingScrollPhysics(),
    autoPlay: true,
    aspectRatio: 1,
    viewportFraction: 1,
    onPageChanged: (index, reason) {
      setState(() {
        currentIndex = index; // Update current index
      });
    },
    initialPage: num?.toInt() ?? 0,
  ),
),

                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList != null
                        ? imageList!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currentIndex == entry.key ? 17 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key ? Colors.red : Colors.teal,
                                ),
                              ),
                            );
                          }).toList()
                        : [],
                  ),
                ),
              ],
            )
          else
            Center(child: CircularProgressIndicator()),

          // House Information
          GestureDetector(
            onTap: () async {
              String? userNumber = await SharedPreferenceHelper().getNumber();
              if (userNumber != null) {
                setState(() {
                  currentIndex = int.parse(userNumber);
                  carouselController.animateToPage(currentIndex);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "House Information",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      decorationThickness: 3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye),
                        SizedBox(width: 10),
                        Text(plus != null ? "$plus" : "Loading..."), // Display updated plus value
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Image thumbnail scroll
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 1),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (displayedImages.isNotEmpty)
                      ...displayedImages.asMap().entries.map(
                        (entry) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = entry.key;
                                carouselController.animateToPage(entry.key);
                              });
                              SharedPreferenceHelper().saveUserNumber(entry.key.toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: currentIndex == entry.key ? Colors.blue : Colors.green,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  entry.value,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    if ((imageList?.length ?? 0) > 6)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showAllImages = !showAllImages;
                            updateDisplayedImages();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey.shade700,
                          child: Center(
                            child: Text(
                              showAllImages ? 'Less' : '+${widget.categoryModel!.image.length - 2}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
