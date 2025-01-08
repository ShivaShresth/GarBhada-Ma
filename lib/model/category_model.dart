import 'dart:convert';

CategoryModel CategoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String CategoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.image,
    required this.id,
    required this.nonveg,
     required this.name,
    //required this.price,
    required this.description,
    required this.status,
    required this.isFavourite,
    required this.rent,
    required this.address,
    required this.date,
    required this.type,
    required this.landmark,
    required this.floor,
    required this.negotiable,
     required this.roadtype,
    required this.furnishing,
    required this.buildupsqrft,
    required this.phonenumber,
    required this.kitchen,
    required this.bathroom,
    required this.bedroom,
    required this.parking,
    required this.roadsize,
    required this.longitude,
    required this.latitude,
     this.view=0,
     this.viewId,
  });

  final List<dynamic> image;
  String id;
  String nonveg;
   String name;
  //double price;
  String description;
  String status;
  bool isFavourite;
  String rent;
  String address;
  String date;
  String type;
  String landmark;
  String floor;
  String negotiable;
   String roadtype;
  String furnishing;
  String buildupsqrft;
  String phonenumber;
  String kitchen;
  String bathroom;
  String bedroom;
  String parking;
  String roadsize;
  String longitude;
  String latitude;
  String? viewId;
  int? view;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"],
      nonveg: json["nonveg"],
       name: json["name"],
      description: json["description"],
      image: json["image"],
      isFavourite: json["isFavourite"],
     // price: double.parse(json["price"].toString()),
      status: json["status"],
      rent: json["rent"],
      address: json["address"],
      date: json["date"],
      type: json["type"],
      landmark:json["landmark"],
      floor: json["floor"],
      negotiable: json["negotiable"],
       roadtype: json["roadtype"],
      furnishing: json["furnishing"],
      buildupsqrft: json["buildupsqrft"],
      phonenumber: json["phonenumber"],
      kitchen: json['kitchen'],
      bathroom: json['bathroom'],
      bedroom: json['bedroom'],
      parking: json['parking'],
      roadsize: json['roadsize'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      view:json['view'],
      viewId: json['viewId']
      
      );

  Map<String, dynamic> toJson() => {
        "id": id??"",
         "name": name??"Not Available",
        "image": image??[],
        "description": description??"Not Available",
        "isFavourite": isFavourite??false,
        "nonveg":nonveg??"Not Available",
        //"price": price,
        "status": status??"Not Available",
        "rent":rent??"Not Available",
        "address":address??"Not Available",
        "date":date??"",
        "type":type??"Not Available",
        "landmark":landmark??"Not Available",
        "floor":floor??"Not Available",
        "negotiable":negotiable??"Not Available",
         "roadtype":roadtype??"Not Available",
        "furnishing":furnishing??"Not Available",
        "buildupsqrft":buildupsqrft??"Not Available",
        "phonenumber":phonenumber??"Not Available",
        "kitchen":kitchen??"Not Available",
        "bathroom":bathroom??"Not Available",
        "bedroom":bedroom??"Not Available",
        "parking":parking??"Not Available",
        "roadsize":roadsize??"Not Available",
        "longitude":longitude??"",
        "latitude":latitude??"",
        "view":view??"",
        "viewId":viewId??""
      };

      Map<String, dynamic>toMap(){  
        return{  
             "id": id??"",
         "name": name??"Not Available",
        "image": image??[],
        "description": description??"Not Available",
        "isFavourite": isFavourite??true,
        "nonveg":nonveg??"Not Available",
        //"price": price,
        "status": status??"Not Available",
        "rent":rent??"Not Available",
        "address":address??"Not Available",
        "date":date??"",
        "type":type??"Not Available",
        "landmark":landmark??"Not Available",
        "floor":floor??"Not Available",
        "negotiable":negotiable??"Not Available",
         "roadtype":roadtype??"Not Available",
        "furnishing":furnishing??"Not Available",
        "buildupsqrft":buildupsqrft??"Not Available",
        "phonenumber":phonenumber??"Not Available",
        "kitchen":kitchen??"Not Available",
        "bathroom":bathroom??"Not Available",
        "bedroom":bedroom??"Not Available",
        "parking":parking??"Not Available",
        "roadsize":roadsize??"Not Available",
        "longitude":longitude??"",
        "latitude":latitude??"",
        "view":view??"",
        "viewId":viewId??""
      

        };
      }

      CategoryModel copyWith({  
        String? address,
        int? view
      })=>CategoryModel(image: image, id: id, nonveg: nonveg, name: name, description: description, status: status, isFavourite: isFavourite, rent: rent, address: address??this.address, date: date, type: type, landmark: landmark, floor: floor, negotiable: negotiable, roadtype: roadtype, furnishing: furnishing, buildupsqrft: buildupsqrft, phonenumber: phonenumber, kitchen: kitchen, bathroom: bathroom, bedroom: bedroom, parking: parking, roadsize: roadsize, longitude: longitude, latitude: latitude,view: view?? this.view,viewId: viewId);

}
