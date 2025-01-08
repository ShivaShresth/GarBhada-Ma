import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  List<ProductModel> _cartProductList = [];
  List<ProductModel> _buyProductList = [];
  List<CategoryModel> _userList = [];
  List<ProductModel> productByCategoryList = [];
  List<ProductModel> productByCategoryList2 = [];
 AppProvider() {
    loadFavouriteProducts();  // Load favorites when the provider is initialized
  }


  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productByCategoryList2 = productByCategoryList;
    } else {
      List<String> lowereCaseBrands =
          brands.map((brand) => brand.toLowerCase()).toList();
      productByCategoryList2 = productByCategoryList
          .where((product) =>
              lowereCaseBrands.contains(product.name?.toLowerCase()))
          .toList();
    }
  }

//// Cart Work
  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

////Favourite ////

  List<CategoryModel> _favouriteProductList = [];
  Future<void> addFavouriteProduct(CategoryModel category, String viewId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (!_favouriteProductList.contains(category)) {
    _favouriteProductList.add(category);
        await _updateFirestore(viewId, true);

    await saveFavouriteProducts();
    notifyListeners();
  } else {
    print("Category already in favorites.");
  }
}

Future<void> removeFavouriteProduct(CategoryModel category, String viewId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (_favouriteProductList.contains(category)) {
    _favouriteProductList.remove(category);
    await _updateFirestore(viewId, false);
    await toggleFavouriteProduct(category);
    await saveFavouriteProducts();

    notifyListeners();
  } else {
    print("Category not in favorites.");
  }
}

Future<void> _updateFirestore(String viewId, bool isFavourite) async {
        final user = FirebaseAuth.instance.currentUser;

  DocumentReference doc = FirebaseFirestore.instance
      .collection("cat")
      .doc(user!.uid)
      .collection("cats")
      .doc(viewId);
  
  await doc.set({"isFavourite": isFavourite}, SetOptions(merge: true));
}


// Future<void> addFavouriteProduct(CategoryModel category, String viewId) async {
//       final user = FirebaseAuth.instance.currentUser;

//   _favouriteProductList.add(category);
//      DocumentReference doc = FirebaseFirestore.instance
//           .collection("cat")
//           .doc(user!.uid)
//           .collection("cats")
//           .doc(viewId);

//       // Fetch current view count
//       DocumentSnapshot snapshot = await doc.get();

//       // Cast the data to Map<String, dynamic>
//       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//       // Get the current view count or default to 0
//       bool currentViewCount = data?['isFavourite'] ?? true;

//       // Update the view count
//       await doc.set({"isFavourite": true}, SetOptions(merge: true));
//    //   print("Updated view count for $viewId to ${currentViewCount + 1}");

//   print("your add${_favouriteProductList}");
//       saveFavouriteProducts();
//   notifyListeners();
//   // // Check if the category is already in the favorites
//   // if (!_favouriteProductList.any((item) => item.id == category.id)) {
//   //   _favouriteProductList.add(category);
//   //   await saveFavouriteProducts();
//   //   notifyListeners();
//   //   print("Added to favorites. Total: ${_favouriteProductList.length}");
//   // } else {
//   //   print("Category already in favorites.");
//   // }
// }

//   Future<void> removeFavouriteProduct(CategoryModel category,String viewId) async {
//     print("helsossi  ${viewId}");
//     _favouriteProductList.remove(category);
//        final user = FirebaseAuth.instance.currentUser;
           

//   //_favouriteProductList.add(category);
//      DocumentReference doc = FirebaseFirestore.instance
//           .collection("cat")
//           .doc(user!.uid)
//           .collection("cats")
//           .doc(viewId);

//       // Fetch current view count
//       DocumentSnapshot snapshot = await doc.get();

//       // Cast the data to Map<String, dynamic>
//       Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

//       // Get the current view count or default to 0
//       bool currentViewCount = data?['isFavourite'] ?? false;

//       // Update the view count
//       await doc.set({"isFavourite": false}, SetOptions(merge: true));
//    //   print("Updated view count for $viewId to ${currentViewCount + 1}");
//    SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                               prefs.remove(category.description);
                      
                              
//                                 toggleFavouriteProduct(category);
//                                 print("heakiel  ${category.viewId}");
//                                 // appProvider.removeFavouriteProduct(category);
                          
//   print("your add${_favouriteProductList}");
//       saveFavouriteProducts();
//   notifyListeners();
//     // await saveFavouriteProducts();
//     // notifyListeners();
//     // print("Removed from favorites. Total: ${_favouriteProductList.length}");
//   }
  List<CategoryModel> get getFavouriteProductList => _favouriteProductList;
  Future<void> saveFavouriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favouritesJson = _favouriteProductList.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('favourites', favouritesJson);
    print("Saved ${favouritesJson.length} favorites.");
  }
  

    Future<void> loadFavouriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favouritesJson = prefs.getStringList('favourites');

    if (favouritesJson != null) {
      _favouriteProductList = favouritesJson.map((item) {
        final data = json.decode(item);
        return CategoryModel.fromJson(data);
      }).toList();
      print("Loaded ${_favouriteProductList.length} favorites.");
    } else {
      print("No favourites found in SharedPreferences");
    }
    notifyListeners(); // Notify listeners after loading
  }


 Future<void> toggleFavouriteProduct(CategoryModel category) async {
  // Check if the product is already in the favorites list
  if (_favouriteProductList.contains(category)) {
    // If it is, remove it
    _favouriteProductList.remove(category);
    print("Removed favorite with ID: ${category.id}");
  } else {
    // If it's not, add it
    _favouriteProductList.add(category);
    print("Added favorite with ID: ${category.id}");
  }

  // Save the updated list to SharedPreferences
  await saveFavouriteProducts();

  // Notify listeners after updating
  notifyListeners();
}


  // Future<void> loadFavouriteProducts() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? favouritesJson = prefs.getStringList('favourites');

  //   if (favouritesJson != null) {
  //     _favouriteProductList = favouritesJson.map((item) {
  //       final data = json.decode(item);
  //       return CategoryModel.fromJson(data);
  //     }).toList();
  //     print("Loaded ${_favouriteProductList.length} favorites.");
    
  //       notifyListeners();
  //     //   return CategoryModel(
  //     //       name: data['name'],
  //     //       isFavourite: data['isFavourite'],
  //     //       image: [],
  //     //       id: '',
  //     //       nonveg: '',
  //     //       description: '',
  //     //       status: '',
  //     //       rent: '',
  //     //       address: '',
  //     //       date: '',
  //     //       type: '',
  //     //       landmark: '',
  //     //       floor: '',
  //     //       negotiable: '',
  //     //       roadtype: '',
  //     //       furnishing: '',
  //     //       buildupsqrft: '',
  //     //       phonenumber: '',
  //     //       kitchen: '',
  //     //       bathroom: '',
  //     //       bedroom: '',
  //     //       parking: '',
  //     //       roadsize: '',
  //     //       longitude: '',
  //     //       latitude: '');
  //     // }).toList();
  //     print("Loaded favourites:$_favouriteProductList");
  //   }else{  
  //     print("No favourites found in SharedPreferences");
  //   }
  // }

// //User Information

// void getUserInfoFirebase()async{

//  _userModel=await     FirebaseFirestoreHelper.instance.getUserInformation();
//  notifyListeners();
// }

// void updateUserInfoFirebase(BuildContext context,  UserModel userModel,File? file)async{
//   showLoaderDialog(context);

//   if(file==null){
//        _userModel= userModel;

//     await
//   FirebaseFirestore.instance
//   .collection("users")
//   .doc(_userModel!.id)
//   .set(_userModel!.toJson());
//     Navigator.of(context,rootNavigator: true).pop();
//     Navigator.of(context).pop();

//   }else{
//       showLoaderDialog(context);

//     String imageUrl=
//     await FirebaseStorageHelper.instance.uploadUserImage(file);
//    _userModel= userModel.copyWith(image: imageUrl);
//     await
//   FirebaseFirestore.instance
//   .collection("users")
//   .doc(_userModel!.id)
//   .set(_userModel!.toJson());
//   Navigator.of(context,rootNavigator: true).pop();
//       Navigator.of(context).pop();

//   }
//     showMessage("Successfully updated profile");

//     notifyListeners();

//   }

  // Total Price //////

  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  //Buy Product ////

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;

  void getUserInfoFirebase() {}

//   void updateUserList(int index, CategoryModel categoryModel)async{
//   await FirebaseFirestoreHelper.instance.updateUser(categoryModel);

//   //int index=_userList.indexOf(userModel);
//   _userList[index]=categoryModel;
//   notifyListeners();
// }

  void updateUserList(int index, CategoryModel categoryModel) async {
    try {
      await FirebaseFirestoreHelper.instance.updateUser(categoryModel);

      if (index >= 0 && index < _userList.length) {
        _userList[index] = categoryModel;
        notifyListeners();
      } else {
        throw RangeError.range(
            index, 0, _userList.length - 1, 'index', 'Invalid index');
      }
    } catch (e) {
      print('Error updating user list: $e');
      // Handle the error as needed
    }
  }

  Future getProductByCategory(String categoryName) async {
    ProductModel productModel;
    List<ProductModel> newList = [];
    final FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot data = await db.collection("product").get();
    for (var element in data.docs) {
      if (element.exists) {
        if (categoryName == element.get("name")) {
          productModel =
              ProductModel.fromJson(element.data() as Map<String, dynamic>);
          newList.add(productModel);
          notifyListeners();
        }
      }
      productByCategoryList = newList;
      notifyListeners();
      return productByCategoryList;
    }
  }

  List<ProductModel> get productByCategoryLists => productByCategoryList;
}
