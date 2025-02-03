import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/photo_view_page.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SliderScreen extends StatefulWidget {
  final CategoryModel? categoryModel;
  final int? plus;

  SliderScreen({Key? key, this.categoryModel, this.plus}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  List<String>? imageList;
  CarouselSliderController carouselSliderController = CarouselSliderController(); // Use CarouselSliderController
  int currentIndex = 0;
  double? num;
  List<String> displayedImages = [];
  bool showAllImages = false;
  int? plus;

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
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User is not authenticated");
        return;
      }

      DocumentReference docRef = FirebaseFirestore.instance
          .collection("cat")
          .doc(user.uid)
          .collection("cats")
          .doc(widget.categoryModel?.viewId);

      DocumentSnapshot snapshot = await docRef.get();

      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data is Map<String, dynamic>) {
          setState(() {
            plus = data['view'] ?? 0;
            print("Fetched plus value: $plus");
          });
        } else {
          print("No valid data found in the document.");
        }
      } else {
        print("No document found for category: ${widget.categoryModel?.viewId}");
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
      final appProvider = Provider.of<AppProvider>(context);

    double height=MediaQuery.of(context).size.height;
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
                          child: CachedNetworkImage(
                            imageUrl: imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(
                                  child: CircularProgressIndicator(value: downloadProgress.progress),
                                ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        );
                      })
                      .toList(),
                  carouselController: carouselSliderController, // Use the CarouselSliderController here
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
            bottom: 6,
            right: 6,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.all(Radius.circular(100)), 
                  color: Colors.black.withOpacity(0.3)
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      // Toggle the isFavourite property
                      widget.categoryModel!.isFavourite =
                          !widget.categoryModel!.isFavourite;
                    });
                            
                    // Update the favorite list in AppProvider
                    if (widget.categoryModel!.isFavourite) {
                      print("Adding to favorites");
                      appProvider.addFavouriteProduct(
                          widget.categoryModel!, widget.categoryModel!.viewId!);
                    } else {
                      print("Removing from favorites");
                      print("Removing from ${widget.categoryModel!.isFavourite}");
                            
                      appProvider.removeFavouriteProduct(
                          widget.categoryModel!, widget.categoryModel!.viewId!);
                    }
                            
                    print(
                        "Current favorites: ${appProvider.getFavouriteProductList}");
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.favorite,
                      color: widget.categoryModel!.isFavourite
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
                Positioned(
                  bottom: 23,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList != null
                        ? imageList!.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => carouselSliderController.animateToPage(entry.key), // Use the updated method
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
                  carouselSliderController.animateToPage(currentIndex); // Use the updated method
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
                                carouselSliderController.animateToPage(entry.key); // Use the updated method
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
                                child: CachedNetworkImage(
                                  imageUrl: entry.value,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Center(
                                        child: CircularProgressIndicator(value: downloadProgress.progress),
                                      ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
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
