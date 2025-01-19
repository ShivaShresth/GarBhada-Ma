import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/house.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/service/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentIntro extends StatefulWidget {
  final House? house;
  final CategoryModel? categoryModel;

  ContentIntro({Key? key, this.house, this.categoryModel}) : super(key: key);

  @override
  State<ContentIntro> createState() => _ContentIntroState();
}

class _ContentIntroState extends State<ContentIntro> {
  String? number;
  final recommendedList = House.generateRecommended();
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getCategoryList();
    super.initState();
  }

  bool isLoading = false;

  void getCategoryList() async {
    // setState(() {
    //   isLoading = true;
    // });

    // categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    // productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    // productModelList.shuffle();

    // setState(() {
    //   isLoading = false;
    // });
  }

  Uri dialNumber = Uri(scheme: 'tel', path: '');

  callNumber() async {
    await launchUrl(dialNumber);
  }

  directCall() async {
  //  await FlutterPhoneDirectCaller.callNumber('1234567890');
  }

  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postDate);
    int differenceInDays = difference.inDays;

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (differenceInDays == 0) {
      return 'Today';
    } else if (differenceInDays == 1) {
      return '1 day ago';
    } else {
      return '$differenceInDays days ago';

      //return DateFormat('yyyy-MM-dd').format(postDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime postDate = DateTime.parse(widget.categoryModel!.date);

    String formattedDate =
        "${postDate.year}-${postDate.month.toString().padLeft(2, '0')}-${postDate.day.toString().padLeft(2, '0')}";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        GestureDetector(
                            onTap: () async {
                              String? indexNumber =
                                  await SharedPreferenceHelper().getNumber();
                              print("helso${indexNumber}");
                            },
                            child: Text("House Type:-")),
                             SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.categoryModel!.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                        height: 20,
                        width: 293,
                        child: Row(
                          children: [
                            Text("Rent :-"),
                            SizedBox(
                              width: 50,
                            ),
                            Text("${widget.categoryModel!.rent}"),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Per Month")
                          ],
                        )),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            print(widget.categoryModel!.date);
                          },
                          child: Text("Address:- "),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 20,
                          width: 230,
                          child: Text(
                            widget.categoryModel!.address,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text("Post on:-"),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 20,
                          width: 238,
                          child: Text(
                            " ${calculateTimeDifference(widget.categoryModel!.date)}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              number = widget.categoryModel!.phonenumber;
              dialNumber = Uri(scheme: 'tel', path: number!);
              callNumber();
            },
            child: Column(
              children: [
                Icon(
                  Icons.call,
                  size: 40,
                  color: Colors.green,
                ),
                Text("Call"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
