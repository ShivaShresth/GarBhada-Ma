import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:renthouse/constants/constants.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/order_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference productCollection =
      _firebaseFirestore.collection('categories');
  late CollectionReference productCollection1 =
      _firebaseFirestore.collection('product');

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

    Future<List<CategoryModel>> fliters(String?property,String? pricel,String? priceg,  String? bedroom, String? bathroom,String? furnishing ) async {
    try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("type",isEqualTo: property).where('rent',isLessThanOrEqualTo: priceg,isGreaterThanOrEqualTo: pricel,).where("bedroom",isEqualTo: bedroom!).where("bathroom",isEqualTo: bathroom).where("furnishing",isEqualTo: furnishing)
        .get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }



  // Future<List<CategoryModel>> fliters(String?property, String?priceg,String?pricel,String? bedroom,) async {
  //   try {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
  //       .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("type",isEqualTo: property).where('rent',isLessThan: priceg,isGreaterThan: pricel,).where("bedroom",isEqualTo: bedroom!)
  //       .get();
  //     List<CategoryModel> categoriesList = querySnapshot.docs
  //         .map((e) => CategoryModel.fromJson(e.data()))
  //         .toList();
  //     return categoriesList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }



  Future<List<CategoryModel>> getNear(String address) async {
    try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("address",isEqualTo: address)
        .get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
    Future<List<CategoryModel>> getNears(String address) async {
    try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("address",isEqualTo: address)
        .get();
      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }




Future<List<CategoryModel>> getCatss(String? address) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("address",isEqualTo: address)
       .orderBy("view", descending: true) // Order by 'view' field, descending
        .get();

    List<CategoryModel> categoriesList = querySnapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
    
    return categoriesList;
  } catch (e) {
    showMessage(e.toString());
    return [];
  }
}

Future<List<CategoryModel>> getDate(String? address) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("cat").doc(FirebaseAuth.instance.currentUser!.uid).collection("cats").where("address",isEqualTo: address)
        .orderBy("date", descending: true) // Order by 'view' field, descending
        .get();

    List<CategoryModel> categoriesList = querySnapshot.docs
        .map((doc) => CategoryModel.fromJson(doc.data()))
        .toList();
    
    return categoriesList;
  } catch (e) {
    showMessage(e.toString());
    return [];
  }
}



Future<List<CategoryModel>> getCats(String categoryId, String productId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("cats")
            .doc(categoryId)
            .collection("cat")
            .doc(productId)
            .get();

    // Check if the document exists
    if (!querySnapshot.exists) {
      print("Document does not exist");
      return [];
    }

    // Convert the document data to a list of CategoryModel
    // Assuming you're expecting multiple categories but currently fetching one document.
    Map<String, dynamic>? data = querySnapshot.data();
    if (data != null) {
      return [CategoryModel.fromJson(data)];
    } else {
      return [];
    }
  } catch (e) {
    showMessage(e.toString());
    return [];
  }
}




  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("product").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<CategoryModel>> getCat() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("cats").get();

      List<CategoryModel> category = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return category;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;

      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();

      DocumentReference admin = _firebaseFirestore.collection("orders").doc();

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": admin.id,
      });

      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": documentReference.id,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Ordered Successfully");

      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();

      return false;
    }
  }

//Get Order User//
  // Future<List<OrderModel>> getUserOrder() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("usersOrders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();

  //     List<OrderModel> orderList = querySnapshot.docs
  //         .map((element) => OrderModel.fromJson(element.data()))
  //         .toList();
  //     return orderList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }

  Future<List<OrderModel>> getOrders() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("vegetables").get();

      List<OrderModel> categoriesLists =
          querySnapshot.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      return categoriesLists;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  addProducts() async {
    try {
      DocumentReference doc = productCollection1.doc();
      ProductModel product = ProductModel(
          image: "image",
          id: doc.id,
          name: "hello",
          price: 2,
          description: "hi",
          isFavourite: true);
      final productJson = product.toJson();
      doc.set(productJson);
      showMessage("Sucess");
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  void addProduct({
    required List<dynamic> image,
    required String landmark,
    required String rent,
    required String kitchen,
    required String bathroom,
    required String bedroom,
    required String parking,
    required String negotiable,
    required String nonveg,
    required String name,
    required String date,
    required String status,
    required String longitude,
    required String latitude,
    required String floor,
    required String roadtype,
    required String type,
    required String furnishing,
    required String roadsize,
    required String buildupsqrft,
    required String phonenumber,
    required String description,
    required String address,

    //required double price,
    required bool isFavourite,
  }) async {
    try {
      DocumentReference doc = productCollection.doc();
      CategoryModel categoryModel = CategoryModel(
          image: image,
          id: doc.id,
          nonveg: nonveg,
          name: name,
          //price: price=10,
          description: description,
          status: status,
          isFavourite: isFavourite = true,
          rent: rent,
          address: address,
          date: date,
          type: type,
          landmark: landmark,
          floor: floor,
          negotiable: negotiable,
          roadtype: roadtype,
          furnishing: furnishing,
          buildupsqrft: buildupsqrft,
          phonenumber: phonenumber,
          kitchen: kitchen,
          bathroom: bathroom,
          bedroom: bedroom,
          parking: parking,
          roadsize: roadsize,
          longitude: longitude,
          latitude: latitude);
      final productJson = categoryModel.toJson();
      doc.set(productJson);
      showMessage("Sucessful Add Category");
    } catch (e) {
      showMessage(e.toString());
    }
  }

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationToken": token,
      });
    }
  }

  Future<List<CategoryModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("usersOrders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orders")
              .get();

      List<CategoryModel> orderList = querySnapshot.docs
          .map((element) => CategoryModel.fromJson(element.data()))
          .toList();
      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<void> updateUser(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection('categories')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
      showMessage("User updated successfully");
    } catch (e) {
      // Handle errors appropriately, for example, log the error
      print("Error updating user: $e");
      showMessage("Failed to update user");
    }
  }

  Future<void> updateView(CategoryModel categoryModel, int view) async {
    await _firebaseFirestore
        .collection("cat")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cats")
        .doc(categoryModel.viewId)
        .update({"view": view});
  }
}
