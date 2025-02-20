import 'package:flutter/material.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/filter_page_display.dart';

class Filter_Page extends StatefulWidget {
  const Filter_Page({super.key});

  @override
  State<Filter_Page> createState() => _Filter_PageState();
}

class _Filter_PageState extends State<Filter_Page> {
  

  String? property;
  String? range;
  String? bedroom;
  String? bathroom;
  String? furnishing;
  String? price1="0";
  String? price2="0";





  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [Icon(Icons.pages), Text("Property Type")],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {

setState(() {
                          property = "house";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:property=="house"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "House",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  

setState(() {
                          property="apartment";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:property=="apartment"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Apartment",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          property="commerical";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:property=="commerical"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Commerical",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.pages),
                  Text("Price range"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(2)),
                      child: TextField(
                        onChanged: (val){  
price1=val;
                        },
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Text("To"),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(2)),
                      child: TextField(
                        onChanged: (val){  
price2=val; 
                        },
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [Icon(Icons.bed), Text("Bedrooms")],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                   
                  
                    InkWell(
                      onTap: (){  
setState(() {
                          bedroom="1";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bedroom=="1"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bedroom="2";

});
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bedroom=="2"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bedroom="3";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bedroom=="3"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  

setState(() {
                          bedroom="4";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bedroom=="4"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "4",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bedroom="5";

});
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bedroom=="5"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "5",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [Icon(Icons.bed), Text("Bathrooms")],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  
                  children: [
                  
                   
                    InkWell(
                      onTap: (){  
setState(() {
                          bathroom="1";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bathroom=="1"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bathroom="2";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bathroom=="2"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bathroom="3";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bathroom=="3"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          bathroom="4";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bathroom=="4"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "4",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){ 
setState(() {
                          bathroom="5";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:bathroom=="5"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "5",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [Icon(Icons.bed), Text("Furnishings")],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                 
                    InkWell(
                      onTap: (){  
setState(() {
                          furnishing="not-furnished";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:furnishing=="not-furnished"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Not Furnished",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          furnishing="semi-furnished";
                        });
                        
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color:furnishing=="semi-furnished"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Semi-Furnished",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){  
setState(() {
                          furnishing="furnishing";

});                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        decoration: BoxDecoration(
                            color: furnishing=="furnishing"?Colors.green: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Fully Furnished",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 4.6,
              ),
              InkWell(
                onTap: () {
 Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter_Page_Display(property: property!,priceg: price1!,pricel: price2!,  bedroom: bedroom!,bathroom: bathroom!,furnishing: furnishing!)));
//Navigator.push(context,MaterialPageRoute(builder: (context)=>Filter_Page_Display(property: property!,priceg:price2! ,pricel:price1! ,bedroom: bedroom!)));
print("${property}");
print("$bathroom");

print("$price1");
print("$price2");
print("$bedroom");

print("$furnishing");


                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "SEARCH FOR RENTED ROOM",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
