import 'package:flutter/material.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/house.dart';
import 'package:renthouse/pages/all_pages/list_of_operator.dart';
import 'package:renthouse/pages/all_pages/most_visited.dart';
import 'package:renthouse/pages/all_pages/recents.dart';
import 'package:renthouse/screen/detail/slider/slider_screen.dart';
import 'package:renthouse/screen/detail/widget/about.dart';
import 'package:renthouse/screen/detail/widget/content_intro.dart';
import 'package:renthouse/screen/detail/widget/detail_app_bar.dart';
import 'package:renthouse/screen/detail/widget/house_info.dart';
import 'package:renthouse/screen/home/widget/near.dart';
import 'package:renthouse/screen/home/widget/recent.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final House? house;
  final CategoryModel? categoryModel;
  final int? plus;

  DetailPage({super.key, this.house, this.categoryModel, this.plus});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? number;
  final Uri whatApp = Uri.parse("https://wa.me/122");


   Uri dialNumber = Uri(scheme: 'tel', path: '');

  callNumber() async {
    await launchUrl(dialNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailAppBar(
                  categoryModel: widget.categoryModel,
                  plus: widget.plus ?? 0,
                ),
                SizedBox(height: 10),
                ContentIntro(categoryModel: widget.categoryModel),
                SizedBox(height: 30),
                List_Of_Operator(categoryModel: widget.categoryModel),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 1.06,
                    color: Colors.grey,
                  ),
                ),
                About(categoryModel: widget.categoryModel),
                SizedBox(height: 20),
               // Text("${widget.categoryModel!.address.length}"),
               Padding(
                 padding: const EdgeInsets.only(left: 16,bottom: 10),
                 child: Text(
                            "Releted",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors
                                    .green, // Optional: Set the underline color
                                decorationThickness: 3,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
               ),
                _buildRecentOrNear(),
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(width: 16,),
                  //Whatup
                  InkWell(
                    onTap: () {
                      launchUrl(whatApp);
                    },
                    child: Icon(Icons.whatshot),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                                    Spacer(),

//email

                  InkWell(
                      onTap: () {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: "bikram@gmail.com",
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Give us a Like',
                            'body': 'D\'ont forget to sucribe the channel',
                          }),
                        );
                        launchUrl(emailUri);

                        // launchEmail('example@example.com', 'Hello!', 'This is a test email body.');
                      },
                      child: Icon(Icons.email)),
                  SizedBox(
                    width: 20,
                  ),
                                    Spacer(),

//phone

                  InkWell(
                    onTap: (){  
                      number = widget.categoryModel!.phonenumber;
              dialNumber = Uri(scheme: 'tel', path: number!);
              callNumber();
                    },
                    child: Icon(Icons.phone)),
                  SizedBox(
                    width: 20,
                  ),
                                    Spacer(),

                  InkWell(
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'sms',
                        path: "1234567890",
                        queryParameters: {'body': 'Hello!'},
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print("show dialog: cannot launch this url");
                      }
                    },
                    child: Icon(Icons.message),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                  //share
                 // Icon(Icons.share),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrNear() {
    final address = widget.categoryModel?.address;

    // if (address != null && address.isNotEmpty) {
    //   return Near(address: address);
    // }

    return Recents();
  }

  void launchEmail(String toEmail, String subject, String body) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: Uri.encodeFull('subject=$subject&body=$body'),
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email client.';
    }
  }

  void sendSMS(String phoneNumber, String message) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: <String, String>{
        'body': message,
      },
    );

    if (await canLaunch(smsUri.toString())) {
      await launch(smsUri.toString());
    } else {
      throw 'Could not launch $smsUri';
    }
  }
}
