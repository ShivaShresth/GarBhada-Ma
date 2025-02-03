import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/constants/routes.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/update_profile.dart';

class Edit_Page extends StatefulWidget {
  const Edit_Page({Key? key}) : super(key: key);

  @override
  State<Edit_Page> createState() => _Edit_PageState();
}

class _Edit_PageState extends State<Edit_Page> {
  late CollectionReference productCollection;
  List<CategoryModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize Firestore and fetch products
    productCollection = FirebaseFirestore.instance.collection('cat').doc(FirebaseAuth.instance.currentUser!.uid).collection("cats");
    fetchProducts();
  }

  fetchProducts() async {  
    productCollection.get().then((QuerySnapshot productSnapshot) {
      final List<CategoryModel> retrievedProducts = productSnapshot.docs
          .map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            // Add the document ID to the data before creating CategoryModel
            data['id'] = doc.id;
            return CategoryModel.fromJson(data);
          })
          .toList();
      setState(() {
        products = retrievedProducts;
        isLoading = false;
      });
    }).catchError((error) {
      print("Error fetching products: $error");
      isLoading = false;
    });
  }

  deleteProduct(String id) async {  
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
      showMessage("Delete Successfully");
      print("Product deleted successfully");
    } on Exception catch (e) {
      showMessage(e.toString());
      print("Error deleting product: $e");
    }
  }

  Future<void> _showDeleteConfirmationDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteProduct(id);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(child: Text("Categories is empty"))
              : Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Set the number of columns in the grid
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      CategoryModel category = products[index];
                      return CupertinoButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Update_Profile(categoryModel: category, index: index)));
                          print("Hellos");
                        },
                        padding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(2, 2),
                                  )
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      category.image[0], // Using the first image only
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Image loaded, show the image
                                          return child;
                                        } else {
                                          // Image is still loading, show progress indicator
                                          return Center(
                                            child: CircularProgressIndicator(),
                                            // child: CircularProgressIndicator(
                                            //   value: loadingProgress.expectedTotalBytes != null
                                            //       ? loadingProgress.cumulativeBytesLoaded /
                                            //           (loadingProgress.expectedTotalBytes ?? 1)
                                            //       : null,
                                            // ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          category.address,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(category.id);
                                  print("welso ${category.id}");
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
