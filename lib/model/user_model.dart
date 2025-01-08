import 'dart:convert';

UserModel UserModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
     required this.name,
     required this.email,
    // required this.price,
    // required this.description,
    // required this.status,
    // required this.isFavourite,
  });

  String? image;
  String id;
   String name;
   String email;
  // double price;
  // String description;
  // String status;
  // bool isFavourite;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
       name: json["name"],
       email: json["email"],
      // description: json["description"],
      image: json["image"],
      // isFavourite: false,
      // price: double.parse(json["price"].toString()),
      // status: json["status"]
      
      );

  Map<String, dynamic> toJson() => {
        "id": id,
         "name": name,
        "image": image,
        "email": email,
        // "description": description,
        // "isFavourite": isFavourite,
        // "price": price,
        // "status": status,
      };

      UserModel copyWith({  

String? name,image, 
})=>UserModel
(
  image: image??this.image, 
id: id, 
name: name??this.name, 
email: email,


);
}
