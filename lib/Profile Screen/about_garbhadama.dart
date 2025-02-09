import 'dart:async';

import 'package:flutter/material.dart';
import 'package:renthouse/Profile%20Screen/term_conditions.dart';
import 'package:shimmer/shimmer.dart';

class About_GarBhadama extends StatefulWidget {
  const About_GarBhadama({super.key});

  @override
  State<About_GarBhadama> createState() => _About_GarBhadamaState();
}

class _About_GarBhadamaState extends State<About_GarBhadama>
    with SingleTickerProviderStateMixin {
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
                              "About Us",
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
                            "About Us",
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
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome to Ghar-Bhadama",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Ghar-Bhadama.com provides services to those who want torent their properties. It is an online marketplace for those who want to deal with properties in Nepal. It is a platform where the buyer and the seller can deal with the properties directly with each other. Bhar-Bhadama.com is simply a bridge between the buyers and the sellers."),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Our Vision",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are someone who wants to rent your properties at a good price then you can post the details about your properties in Ghar-Bhadama.com"),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Ghar-Bhadama.com reviews the information you have provided about your property and publishes it on the website for the public to see. To make the property look nicer in the website, Ghar-Bhadama.com provides you professional photography services. These photos are carefully edited to make it more attractive so that buyers can contact you. Fees are applicable for onsite professional photography services."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "You can start posting your property in the catogry 'Normal listing' on the website which is free of cost. If you want to post your property as featured, which is shown on the homepage, you can request a fetured listing with additional applicable fees. For more details about Ghar-Bhadama.com services, please visit here. Once the property is rent, it will be removed from the website."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Our Mission",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are a buyer, you can find a lot of nice properties and directly contact and negotiate with the sellers."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "If you are thinking of letting our properties for rent, you can also put your property details so that those who are seeking for properties for rent will contact you."),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Information about the properties listed in the site is taken from the consent of the sellers. In case of the wrong information, the seller will be responsible for that. Ghar-Bhadama.com is not responsible for any wwrong information provided by the sellers."),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Text("See more for "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Term_Conditions()));
                      },
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
