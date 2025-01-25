import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_Team extends StatefulWidget {
  const Contact_Team({super.key});

  @override
  State<Contact_Team> createState() => _Contact_TeamState();
}

class _Contact_TeamState extends State<Contact_Team> {
  String? number;
  final Uri whatApp = Uri.parse("https://wa.me/122");


   Uri dialNumber = Uri(scheme: 'tel', path: '');

  callNumber() async {
    await launchUrl(dialNumber);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double  height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Contact Us"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Icon(Icons.phone,size: 80,)),
                                                            SizedBox(height: 10,),

                      Center(child: Text("Call us to get in touch")),
                                      SizedBox(height: 3,),

                      Center(child: Text("9:30 Am to 5:30 PM, Sunday to Friday")),
                                                            SizedBox(height: 26,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){ 
                                number = "9819282992";
              dialNumber = Uri(scheme: 'tel', path: number!);
              callNumber();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(  
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Icon(Icons.phone)),
                          ),
                          InkWell(
                            onTap: ()async{  
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
                            child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(  
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Icon(Icons.message)),
                          ),
                          InkWell(
                            onTap: (){ 
                                                  launchUrl(whatApp);
  
                            },
                            child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(  
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Icon(Icons.whatshot)),
                          ),
                          InkWell(
                            onTap: (){  
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


                            },
                            child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(  
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Icon(Icons.email)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
