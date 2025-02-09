import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_Team extends StatefulWidget {
  const Contact_Team({super.key});

  @override
  State<Contact_Team> createState() => _Contact_TeamState();
}

class _Contact_TeamState extends State<Contact_Team>with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  bool _shimer = false;

  @override
  void initState() {
        Timer(Duration(seconds: 2), () {
      setState(() {
        _shimer = true; // Set _shimer to false after 3 seconds
      });
    });
    // Start a timer
    Timer(Duration(seconds: 3), () {
      setState(() {
        _shimer = false; // Set _shimer to false after 3 seconds
      });
    });
  
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 1.0),
      ),
    );

    _animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.45, 1.0),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return _shimer
                  ? Transform.translate(
                      offset: Offset(-100 * (1 - _animation1.value), 0),
                      child: Opacity(
                        opacity: _animation1.value,
                        child: Shimmer.fromColors(
                            baseColor: Colors.green,
                            highlightColor: Colors.yellow,
                            child: Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            )),
                      ),
                    )
                  : Transform.translate(
                      offset: Offset(-100 * (1 - _animation1.value), 0),

                      child: Opacity(
                          opacity: _animation1.value,

                          // child: Shimmer.fromColors(
                          //        baseColor: Colors.green,
                          //                       highlightColor: Colors.yellow,
                          child: Text(
                            "Contact Us",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                      // ),
                    );
            }),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
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
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Image.asset('assets/call.webp',height: 50,)
                              ),
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
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Image.asset('assets/message.png',height: 50,)
                              ),
                          ),
                          InkWell(
                            onTap: (){ 
                                                  launchUrl(whatApp);
  
                            },
                            child: Container(
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(  
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Image.asset('assets/whatapp.png',height: 50,)
                              ),
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
                                borderRadius: BorderRadius.circular(100)
                              ),
                              child: Image.asset('assets/gmail.png',height: 50,)
                              ),
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
