import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/pages/all_pages/filter.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/screen/home/widget/searchpage.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  List<ProductModel> searchList = []; // Corrected to ProductModel
  bool isLoading = false;
  String name="water";
  String val="";



  // @override
  // void initState() {
  //   searchController.clear();
  //   super.initState();
  //   // Optionally, initialize the controller with any previous value
  // }

  //   @override
  // void dispose() {
  //       searchController.clear();

  //   searchController.dispose(); // Dispose of the controller
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  //   appProvider.getUserInfoFirebase();
  //   getCategoryList();
  // }

  // void getCategoryList() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   categoriesList = await FirebaseFirestoreHelper.instance.getNears(name);
  //   productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
  //   productModelList.shuffle();

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

   TextEditingController searchController = TextEditingController();

  // void searchProducts(String value) {
  //   setState(() {
  //     searchList = productModelList
  //         .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 2),
      child: Row(
        
        children: [
          Container(
            width: width*0.8,
            child: TextField(
              controller: searchController,
              onChanged: (String value) {
               // searchProducts(value);
                val=value.trim();
              },
              onSubmitted: (String value) {
                // Navigate when the user presses the "search" button on the keyboard
                if (val.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search_Page(val: val),
                    ),
                  );
                }
              },
              decoration: InputDecoration(
                
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Search here...",
                prefixIcon: Container(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: (){  
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Search_Page(val: val,)));
                    },
                    child: Icon(Icons.search, color: Colors.black45)),
                ),
                contentPadding: EdgeInsets.only(left: 20),
              ),
            ),
          ),
          InkWell(
            onTap: (){  
Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter_Page()));
            },
            child: Icon(Icons.filter_list))
        
          ]
        
      ),
    );
  }
}
