import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:renthouse/Profile%20Screen/about_garbhadama.dart';
import 'package:renthouse/Profile%20Screen/contact_team.dart';
import 'package:renthouse/Profile%20Screen/privacy_policy.dart';
import 'package:renthouse/Profile%20Screen/term_conditions.dart';
import 'package:renthouse/pages/all_pages/alter_page.dart';
import 'package:renthouse/pages/all_pages/order2.dart';
import 'package:renthouse/pages/all_pages/take_photo.dart';
import 'package:renthouse/pages/edit_profile.dart';

class FirebaseFirestoreHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  // Function to fetch category data
  Future<List<CategoryModel>> takePhotget() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
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

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoading = false;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categories = await FirebaseFirestoreHelper().takePhotget();

    // // Shuffle only if the toprent flag is false, and shuffle only once during initialization.
    // if (widget.toprent == null || widget.toprent == false) {
    //   categoriesList.shuffle();
    // }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // AppProvider appProvider = Provider.of<AppProvider>(
    //   context,
    // );

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Align(
      //     alignment: Alignment.topLeft,
      //     child: Padding(
      //       padding: const EdgeInsets.only(left: 0),
      //       child: Text(
      //         "Settings",
      //         style: TextStyle(
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 28),
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   elevation: 1,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white),
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                FutureBuilder<List<CategoryModel>>(
                  future: FirebaseFirestoreHelper().takePhotget(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Align(
                          alignment: Alignment.bottomRight,
                          child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error loading image: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      // Debugging: Check image URL received from Firestore
                      List<dynamic> imageUrl = snapshot.data![0].imageUrls;
                      print('Received Image URL: $imageUrl');

                      if (imageUrl.isEmpty) {
                        return Text('Image URL is empty.');
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hello, Guest",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        Take_Photo(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      // Slide the page from left to right
                                      const begin = Offset(
                                          1.0, 0.0); // Start from the left
                                      const end = Offset
                                          .zero; // End at the default position (right)

                                      var tween = Tween(begin: begin, end: end);
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                          position: offsetAnimation,
                                          child: child);
                                    },
                                  ),
                                );
                              },

                              //  onTap: _pickImages,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5, color: Colors.grey.shade700),
                                    shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl[0],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hello,Guest",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      Take_Photo(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    // Slide the page from left to right
                                    const begin =
                                        Offset(1.0, 0.0); // Start from the left
                                    const end = Offset
                                        .zero; // End at the default position (right)

                                    var tween = Tween(begin: begin, end: end);
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                ),
                              );
                            },

                            //onTap: _pickImages, // Open gallery to pick multiple images
                            child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5, color: Colors.grey.shade700),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 80,
                                )),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 20),
                //       child: Align(
                //           alignment: Alignment.topLeft, child: Text("Hello,Guest",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),  )),
                //     ),
                //     InkWell(
                //       onTap: (){

                //        Navigator.push(
                //           context,
                //           PageRouteBuilder(
                //             pageBuilder: (context, animation, secondaryAnimation) => Take_Photo(),
                //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
                //               // Slide the page from left to right
                //               const begin = Offset(1.0, 0.0); // Start from the left
                //               const end = Offset.zero; // End at the default position (right)

                //               var tween = Tween(begin: begin, end: end);
                //               var offsetAnimation = animation.drive(tween);

                //               return SlideTransition(position: offsetAnimation, child: child);
                //             },
                //           ),
                //         );
                //       },
                //       child: Padding(
                //         padding: const EdgeInsets.only(right: 10),
                //         child: Container(
                //           padding: EdgeInsets.all(10),
                //           decoration: BoxDecoration(

                //             border: Border.all(color: Colors.grey.shade700,width: 3),
                //             shape: BoxShape.circle,
                //           ),
                //           child: Icon(Icons.person_outline,size: 40,color: Colors.grey.shade700,)),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 40,
                // ),
                Container(
                  child: Column(
                    children: [
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Edit_Page(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // Slide the page from left to right
                                const begin =
                                    Offset(1.0, 0.0); // Start from the left
                                const end = Offset
                                    .zero; // End at the default position (right)

                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          title: Text("Edit"),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      About_GarBhadama(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // Slide the page from left to right
                                const begin =
                                    Offset(1.0, 0.0); // Start from the left
                                const end = Offset
                                    .zero; // End at the default position (right)

                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => About_GarBhadama()));

                          //   // Routes.instance
                          //   // .push(widget: FavouriteScreen(), context: context);
                          // },
                          leading: Icon(Icons.house_outlined),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),

                          title: Text("About GarBhadama"),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PrivacyPolicy(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // Slide the page from left to right
                                const begin =
                                    Offset(1.0, 0.0); // Start from the left
                                const end = Offset
                                    .zero; // End at the default position (right)

                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => PrivacyPolicy()));
                          // },
                          leading: Icon(Icons.privacy_tip_outlined),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),

                          title: Text("Privacy Policy"),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Term_Conditions(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // Slide the page from left to right
                                const begin =
                                    Offset(1.0, 0.0); // Start from the left
                                const end = Offset
                                    .zero; // End at the default position (right)

                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Term_Conditions()));
                          // },
                          leading: Icon(Icons.list_alt_outlined),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),

                          title: Text("Term & Conditions"),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Contact_Team(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                // Slide the page from left to right
                                const begin =
                                    Offset(1.0, 0.0); // Start from the left
                                const end = Offset
                                    .zero; // End at the default position (right)

                                var tween = Tween(begin: begin, end: end);
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: ListTile(
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Contact_Team()));
                          // },
                          leading: Icon(Icons.email_outlined),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),

                          title: Text("Contact our team"),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          setState(() {});
                        },
                        leading: Icon(Icons.exit_to_app),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        title: Text("Log Out"),
                      ),
                      Divider(),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Version 1.0.0"),
                      SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
