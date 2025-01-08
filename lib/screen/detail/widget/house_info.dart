import 'package:flutter/material.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/slider/slider_screen.dart';
import 'package:renthouse/service/shared_pref.dart';

class HouseInfo extends StatefulWidget {
  final CategoryModel? categoryModel;

  const HouseInfo({Key? key, this.categoryModel}) : super(key: key);

  @override
  State<HouseInfo> createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  List<String> displayedImages = [];
  bool showAllImages = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    updateDisplayedImages();
  }

  void updateDisplayedImages() {
    List<dynamic> images = widget.categoryModel!.image;
    displayedImages = images.cast<String>().take(2).toList();
  }

  void selectImage(int index) {
    setState(() {
      selectedIndex = index;
    });
  
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async{
    String? userNumber = await SharedPreferenceHelper().getNumber();
                                            print("hellos${userNumber}");

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "House Information",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  decorationThickness: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 1),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: displayedImages
                              .asMap()
                              .entries
                              .map(
                                (entry) => GestureDetector(
                                  onTap: () {
                                    selectImage(entry.key);
                                        SharedPreferenceHelper().saveUserNumber(entry.key.toString());


                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndex == entry.key
                                            ? Colors.blue // Highlight selected image
                                            : Colors.green,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(3),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: Offset(2, 2),
                                          )
                                        ],
                                      ),
                                      child: Image.network(
                                        entry.value,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                  ),

                     if (widget.categoryModel!.image.length > 2)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showAllImages = !showAllImages;
                          if (showAllImages) {
                            displayedImages = widget.categoryModel!.image
                                .cast<String>()
                                .toList();
                          } else {
                            updateDisplayedImages();
                          }
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey.shade700,
                        child: Center(
                          child: Text(
                            showAllImages
                                ? 'Less'
                                : '+${widget.categoryModel!.image.length - 2}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),
               
                    
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
