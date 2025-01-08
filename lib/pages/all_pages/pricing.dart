import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Pricing extends StatefulWidget {
  const Pricing({super.key});

  @override
  State<Pricing> createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  String? number;
  final Uri whatApp = Uri.parse("https://wa.me/122");


   Uri dialNumber = Uri(scheme: 'tel', path: '');

  callNumber() async {
    await launchUrl(dialNumber);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Pricing"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pricing",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 25),),
                        Text(
                            "GharBhadaMa provides different kinds of services for the buyers and sellers of properties in Nepal. If you are a seller, you choose among the following types of services which are best fit for your property.",style: TextStyle(color: Colors.black,fontSize: 16) ,),
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.yellow.shade200),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NORMAL LISTING",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                                                SizedBox(height: 10,),

                        Text("NRs. 5,000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20) ),
                                                SizedBox(height: 10,),

                        Text("1) High quality property images.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                        SizedBox(height: 6,),
                        Text("2) Listing on the website and app.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                SizedBox(height: 6,),

                        Text("3) 1-Week facebook sponsored promotion.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                SizedBox(height: 6,),

                        Text("4) Listed until the property is sold.",style: TextStyle(color: Colors.black,fontSize: 16) )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: width,
                                    padding: EdgeInsets.symmetric(vertical: 20),

                  decoration: BoxDecoration(color: Colors.green.shade400),
                  child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FEATURED LISTING",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                                                                        SizedBox(height: 10,),

                        Text("NRs. 10,000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                                                                        SizedBox(height: 10,),

                        Text("1) High quality property images.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text("2) Listing on the website and app.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text("3) 2-Weeks facebook sponsored promotion per month.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text(
                            "4) Tiktok video promotion featuring a professionally shot video by a photographer.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                            SizedBox(height: 10,),

                        Text("5) Listing until the property is sold.",style: TextStyle(color: Colors.black,fontSize: 16) )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.blue.shade400),
                  child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PREMIUM LISTING",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                        Text("NRs. 15,000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                                                                                                SizedBox(height: 10,),

                        Text("1) High quality property images.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text("2) Listing on the website and app.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text(
                            "3) 3-Weeks facebook sponsored promotion within the month. With double the budget comapred to the normal listing.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                      SizedBox(height: 10,),

                        Text(
                            "4) Youtube/Ticktok video promotion featuring a professionally shot video by a photographer.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text("5) This option ideal for urgent sales.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text("6) Listing until the property is sold.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                      width: width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(color: Colors.pink.shade400),
                  child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("TOP LISTING",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                        Text("NRs. 20,000",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)  ),
                                                                                                SizedBox(height: 10,),

                        Text("1) High quality property images.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text("2) Listing on the website and app.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                        SizedBox(height: 10,),

                        Text(
                            "3) 4-Weeks facebook sponsored promotion within the month. With double the budget compared to the premium listing.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                      SizedBox(height: 10,),

                        Text(
                            "4) Youtube/ Tiktok video promotion featuring a professionally shot video by a photographer.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text(
                            "5) GarBhadMa will refer walk-in customers directly to the property.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text("6) Full-page Ad(Jacket Page) for a week.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text(
                            "7) This option ideal for urgent sales, plottings, and real estate companies.",style: TextStyle(color: Colors.black,fontSize: 16) ),
                                                                       SizedBox(height: 10,),

                        Text("8) Listing until the property is sold.",style: TextStyle(color: Colors.black,fontSize: 16)  )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 20) ,
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "If you are confused about which services to choose, you can simply contact us. Our team will help you select the suitable service for you depending upon the nature of your property and your immediate need. ",style: TextStyle(color: Colors.black,fontSize: 16)),
                                     SizedBox(
                  height: 20,
                ),

                      Text(
                          "Buyers can contact us to get advice and find the right properties for them in Nepal at a reasonable price. We can advise you on the current scenario in the real estate market in Nepal. If you are planning to take home loans, you can check the home loan interest rate which is provided by different commerical banks in Nepal.",style: TextStyle(color: Colors.black,fontSize: 16)),
                                     SizedBox(
                  height: 20,
                ),

                      Text(
                          "Future, it is useful for buyers/ sellers to know about the things that should be taken into consideration before making a property deal in Nepal. It will be equally helpful for you to happening in the real estate market in Nepal. We have all real estate related news in one place.",style: TextStyle(color: Colors.black,fontSize: 16))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
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
