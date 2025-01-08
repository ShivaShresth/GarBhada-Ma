class ImageModel {
  ImageModel({
    required this.itemImageUrls,
  });
  String itemImageUrls;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(itemImageUrls: json['itemImageUrls']);

  Map<String, dynamic> toJson() => {
        "itemImageUrls": itemImageUrls,
      };

    
}
