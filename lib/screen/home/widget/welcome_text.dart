import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  _WelcomeTextState createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  bool _isShimmerActive = true;

  @override
  void initState() {
    super.initState();
    // Set a timer to stop shimmer effect after 3 seconds
    Timer(Duration(seconds: 6), () {
      setState(() {
        _isShimmerActive = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 20, bottom: 10, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  _isShimmerActive
                      ? Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.yellow,
                          child: Text(" Ghar-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                        )
                      : Text(" Ghar-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                  _isShimmerActive
                      ? Shimmer.fromColors(
                          baseColor: Colors.black87,
                          highlightColor: Colors.green,
                          child: Text("BhadaMa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                        )
                      : Text("BhadaMa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                ],
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/b.png'),
          ),
        ],
      ),
    );
  }
}
