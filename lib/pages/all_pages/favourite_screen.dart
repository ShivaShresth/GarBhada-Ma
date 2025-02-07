import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import '../../provider/app_provider.dart';
import 'package:renthouse/screen/detail/widget/detail_app_bar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final appProvider = Provider.of<AppProvider>(context, listen: false);
      await appProvider.loadFavouriteProducts();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Favourite Screen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : appProvider.getFavouriteProductList.isEmpty
              ? Center(
                  child: Text(
                    "No favourites yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: appProvider.getFavouriteProductList.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (ctx, index) {
                    CategoryModel category =
                        appProvider.getFavouriteProductList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              categoryModel:appProvider. getFavouriteProductList[index],
                              plus: 1,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: category.image.isNotEmpty
                              ? Image.network(
                                  category.image[0],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                    child: Text("Not Available"),
                                  ),
                                ),
                          title: Text(category.name ?? "Unnamed Category"),
                          subtitle: Text(category.description ??
                              "No description available"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove(category.description!);

                              final user = FirebaseAuth.instance.currentUser;
                              final viewId = category.viewId;

                              DocumentReference doc = FirebaseFirestore
                                  .instance
                                  .collection("cat")
                                  .doc(user!.uid)
                                  .collection("cats")
                                  .doc(viewId);

                              try {
                                await doc.set(
                                  {"isFavourite": false},
                                  SetOptions(merge: true),
                                );

                                appProvider.toggleFavouriteProduct(category);
                              } catch (e) {
                                print("Error removing from Firestore: $e");
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
