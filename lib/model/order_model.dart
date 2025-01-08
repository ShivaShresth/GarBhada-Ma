import 'dart:convert';

import 'package:renthouse/model/image_model.dart';
import 'package:renthouse/model/product_model.dart';


class OrderModel {
  OrderModel({

// required this.totalPrice,
//    required this.name,
// required this.address,
     required this.image,
    // required this.game,
    //required this.price,
    // required this.description,
    // required this.status,
    // required this.isFavourite,
  });

  // String name;
   //String landmark;
  List<dynamic> image;
  // double totalPrice;
 //  String image;
  

  // double price;
  //String address; 
 // String image;
  // bool isFavourite;

  factory OrderModel.fromJson(Map<String, dynamic> json){
 // List<dynamic> productMap=json["image"];
  
  
    return OrderModel(
     // orderId: json["orderId"],
       //image: productMap.map((e) => ImageModel.fromJson(e)).toList(),
      //  name: json["name"],
      //  address: json["address"],
       image: json["itemImageUrls"],
     // game: json["game"],
      // isFavourite: false,
      // price: double.parse(json["price"].toString()),
      // status: json["status"]
      
      );

  }



}
