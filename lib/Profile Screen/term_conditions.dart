import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Term_Conditions extends StatefulWidget {
  const Term_Conditions({super.key});

  @override
  State<Term_Conditions> createState() => _Term_ConditionsState();
}

class _Term_ConditionsState extends State<Term_Conditions>with SingleTickerProviderStateMixin{
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

  @override
  Widget build(BuildContext context) {
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
                              "Term & Conditions",
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
                            "Term & Conditions",
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
     
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
          child: Column(  
            children: [  
              
              SizedBox(height: 10,),
              Align(
                alignment:Alignment.topLeft,
                child: Text("ACCEPTANCE OF TERMS",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18), )),
                         SizedBox(height: 10,),
          
              Text("You must accept these terms of service to use Ghar-Bhadama.com This is a legal agreement (\"Agreement\") between You and Ghar-Bhadama.com Pvt.Ltd (\"Company\"), for use of the Gharbazar.come service. \"You\" refers to the person who har registered or taken any services form Ghar-Bhadama.com. You have to acknowledge these terms as a contract between you and Ghar-Bhadama.com."),
                      SizedBox(height: 10,),
          
            Align(
              alignment: Alignment.topLeft,
              child: Text("SERVICES",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
           Text("The Company may as its sole discretion modify the features of the Services from time to time without prior notice. Ghar-Bhadama.com reserves the right at any time and from time to time to modify or discontinue, temprarily or permanently, the Service (or any part thereof) with or without notice."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("ACCOUNTS, PASSWORD AND SECURITY",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
            Text("You will receive a password and account designation upon completing the Service's registration process. You are responsible for maintaining the confidentiality of the password and account. Your password is stored in hashed and encrypted manner, using highly secured algorithms, even though we can't decipher it."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("CONTENT AND DATAS",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
            Text("We claim no intellectual property rights over the data and material you provide to the website. All materials uplodaed remain yours."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("ACCOUNT DAT DELETEION",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
            Text("We don't share anything we gather from you or from your social account you used to login. But still if you want to deactive/ delete your account and all the information linked with your account, please feel free to contact us in our emain shivashrestha1056@gmail.com with your login username and your mobile number. We'll get back to you as soon as possible"),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("DISPUTE BETWEEN BUYER AND SELLER",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
            Text("Situations may come where there is dispute between they buyer and seller. Ghar-Bhadama.com between the buyer and seller. Gha-Bhadama.com does not guarantee or promise anything in terms of the correctness of the information provided by the seller or buyer. For any damages to the seller due to the buyer and any damage due to the buyer due to the seller, Ghar-Bhadama.com will not be absolutely responsible of that."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("CONDUCT ON GHAR-BAHDAMA.COM",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
 Text("You may not use the Ghar-Bhadama.com Platform to:"),
                      SizedBox(height: 10,),
  Text("Upload post, transmit, or otherwise make available any of Your Data that is unlawful, harmful, threateing,abusive, harassing, tortious, defamatory,vulgar, obscene, libelous, invasive of another's privacy, hateful or racially, ethnically, or otherwise objectionable."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("BILLING",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                      SizedBox(height: 10,),
            Text("You are not obligated to purchase any of the Services. If You elect to purcahse Service packages or aditional Services, you may elect to provided a credit card or other payment mechanism selected by you."),
                       SizedBox(height: 10,),
           Text("You agree that the Company may chnage to Your credit Card or ther payment mechanism selected by You and approvied by the Company for Your Prepaid Account(\"Your Account\" and all amounts due and owing for the Sevices, including service fees, subscription fees or any other feee or charge associated with Your use of the Services."),
                       SizedBox(height: 10,),
           Align(
            alignment: Alignment.topLeft,
            child: Text("Prices of all Services are subject to chane at any time.")),
                       SizedBox(height: 10,),
           Text("All payments authorized by you into your account are final. There is no refunding of your account regardless of whethere you use the Services or not."),
                       SizedBox(height: 10,),
           Text("Government Taxes will be applicable wherever necessary."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("CHANGING YOUR SERVICE LEVEL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
           Text("Some services provided by Ghar-Bhadama.com allow you to upgrade your service levels."),
                       SizedBox(height: 10,),
           Text("If you upgrade your service level from one package to a higher priced package, the Company will charge you the applicable amount"),
                       SizedBox(height: 10,),
           Text("There are no downgrade options available and no refunds."),
                        SizedBox(height: 10,),
          Align(
              alignment: Alignment.topLeft,
              child: Text("CANCELLATION OF ACCOUNT",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
           Text("You are solely responsible for property canceling your account. An email is necessary to cancel your account, Ghar-Bhadama.com will cancel your account once email confirmation is received. All of you content will immediately be inaccessible from the Service upon cancellation. This information cannot be recovered once the account has been canceled."),
                       SizedBox(height: 10,),
           Align(
              alignment: Alignment.topLeft,
              child: Text("GOVERNING LAW",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
           Text("These Temrs will be governed by the laws of the Ferdderal Democratic Republic of Nepal, without regard to it conflict of laws principles."),
                      SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Text("DISCLAIMER; limitation of liability",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)),
                       SizedBox(height: 10,),
           Text("Errors. A possibility exists that our website or materials could include inaccuracies or errors. or infomation or materials that voilate these Terms. Additionally, a possibility exists that unauthorized alterations could be made by third parties to our website or materials. Although we attemtp to ensure the integrity of our website, we make no guarantees as to its completeness or correctness. If a situation arises in which our website's completeness or correctness is in question, please contact us via our contact information provided on our \"Support\" page of the website with, if possible, a description of the material to be checked and the location (URL) where such material can be found on our webstie."),
                        SizedBox(height: 10,),
          Text("If you have any questions regarding this Agreement or If you wish to discuss the terms of service contained herein please contact Ghar-Bhadama.come Limited using the contact details at our contact page.")
          
          
            
            ],
          ),
        ),
      ),
    );
  }
}