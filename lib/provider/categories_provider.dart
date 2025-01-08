import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renthouse/model/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<CategoryModel> categoryList = [];

  Future<List<CategoryModel>> getCategoriesData() async {
try{  
      List<CategoryModel> newList = [];
       QuerySnapshot<Map<String, dynamic>> data =
          await db.collection("categories").get();
print('ehl${data}');
   // QuerySnapshot data = await db.collection("categories").get();
    for (QueryDocumentSnapshot element in data.docs) {
      if (element.exists) {
        CategoryModel categoryModel =
            CategoryModel.fromJson(element.data() as Map<String, dynamic>);
        newList.add(categoryModel);
      }
    }

    categoryList = newList;
    notifyListeners();

    return categoryList;
}catch(e){ 
    print('helso${e}');
    return [];
  }
  }
}
